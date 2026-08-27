local autocmd = vim.api.nvim_create_autocmd

local function sync_theme_with_system()
  vim.system({ "defaults", "read", "-g", "AppleInterfaceStyle" }, { text = true }, function(obj)
    local is_dark = (obj.code == 0 and (obj.stdout or ""):find("Dark") ~= nil)

    vim.schedule(function()
      local base46 = require "base46"
      local nvconfig = require "nvconfig"
      local current_theme = nvconfig.base46.theme
      local toggle_themes = nvconfig.base46.theme_toggle or { "chadracula", "one_light" }

      local dark_theme = toggle_themes[1]
      local light_theme = toggle_themes[2]

      for _, theme_name in ipairs(toggle_themes) do
        local ok, t = pcall(require, "base46.themes." .. theme_name)
        if ok and t and t.type then
          if t.type == "dark" then
            dark_theme = theme_name
          elseif t.type == "light" then
            light_theme = theme_name
          end
        end
      end

      local target_theme = is_dark and dark_theme or light_theme

      if current_theme ~= target_theme then
        nvconfig.base46.theme = target_theme
        pcall(function()
          package.loaded.chadrc = nil
          local chadrc = require "chadrc"
          local old_theme = chadrc.base46.theme
          if old_theme and old_theme ~= target_theme then
            require("nvchad.utils").replace_word('theme = "' .. old_theme, 'theme = "' .. target_theme)
          end
        end)
        base46.load_all_highlights()
      end
    end)
  end)
end

autocmd({ "FocusGained", "UIEnter" }, {
  callback = sync_theme_with_system,
})
