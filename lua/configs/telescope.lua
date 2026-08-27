require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "%.git/",
      "%.cache",
      "%.class",
      "%.pdf", "%.png", "%.jpg", "%.jpeg",
    },
  },
  extensions = {
    recent_files = {
      stat_files = true,
    },
  },
}

require("telescope").load_extension "recent_files"
