return {
  "mason-org/mason-lspconfig.nvim",
  event = "VeryLazy",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "eslint",
      "docker_compose_language_service",
      "dockerls",
      "lua_ls",
      "rubocop",
      "ruby_lsp",
    }
  },
}
