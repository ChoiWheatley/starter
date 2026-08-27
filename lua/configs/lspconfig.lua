-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- EXAMPLE
local servers = { "html", "cssls", "ts_ls", "prismals" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
end
vim.lsp.enable(servers)

-- python-lsp-server setup
vim.lsp.config("pylsp", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    black = { enabled = true },
    autopep8 = { enabled = false },
    yapf = { enabled = false },
    pylint = { enabled = true, executable = "pylint" },
    pyflakes = { enabled = false },
    pycodestyle = { enabled = false },
    pylsp_mypy = { enabled = true },
    jedi_completion = { fuzzy = true },
    pyls_isort = { enabled = true },
  },
})
vim.lsp.enable "pylsp"
