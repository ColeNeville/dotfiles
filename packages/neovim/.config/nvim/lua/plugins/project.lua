return {
  "ahmedkhalf/project.nvim",
  opts = {
    detection_methods = { "pattern" },
    patterns = { ".git" },
    ignore_lsp = { "lua_ls" },
    silent_chdir = false,
  },
}
