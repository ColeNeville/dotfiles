return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruby_lsp = {
        init_options = {
          provideFormatter = false,
        },
      },
      vtsls = {
        init_options = {
          provideFormatter = false,
        },
      },
    },
  },
}
