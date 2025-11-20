return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruby_lsp = {
        init_options = {
          provideFormatter = false,
        },
      },
    },
    setup = {
      vtsls = function(_, _)
        LazyVim.lsp.on_attach(function(client, _)
          -- Disable document formatting for vtsls
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end, "vtsls")
      end,
    },
  },
}
