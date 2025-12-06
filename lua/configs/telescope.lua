require("telescope").load_extension("recent_files")
require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "%.git/",
      "%.cache",
      "%.class",
      "%.pdf", "%.png", "%.jpg", "%.jpeg"
    }
  }
}
