return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      mode = { "n" },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format()
        end,
        desc = "Format buffer (LSP)"
      },
      {
        "<leader>la",
        function()
          vim.lsp.buf.code_action()
        end,
        desc = "Code actions (LSP)"
      },
      {
        "<leader>lr",
        function()
          vim.lsp.buf.rename()
        end,
        desc = "Rename symbol (LSP)"
      },
      {
        "<leader>ld",
        function()
          vim.lsp.buf.definition()
        end,
        desc = "Go to definition (LSP)"
      },
      {
        "<leader>lh",
        function()
          vim.lsp.buf.hover()
        end,
        desc = "Show hover info (LSP)"
      },
      {
        "<leader>lt",
        function()
          vim.lsp.buf.type_definition()
        end,
        desc = "Go to type definition (LSP)"
      },
      {
        "]d",
        function()
          vim.diagnostic.goto_next()
        end,
        desc = "Next diagnostic"
      },
      {
        "[d",
        function()
          vim.diagnostic.goto_prev()
        end,
        desc = "Previous diagnostic"
      },
      {
        "]e",
        function()
          vim.diagnostic.goto_next(
            {
              severity = vim.diagnostic.severity.ERROR
            }
          )
        end,
        desc = "Next error"
      },
      {
        "[e",
        function()
          vim.diagnostic.goto_prev(
            {
              severity = vim.diagnostic.severity.ERROR
            }
          )
        end,
        desc = "Previous error"
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = {
      mode = "n",
      {
        "<leader>lm",
        "<cmd>Mason<cr>",
        desc = "Open package manager (Mason)",
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<leader>td",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Toggle buffer diagnostics (Trouble)",
      },
      {
        "<leader>tD",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle workspace diagnostics (Trouble)",
      },
    },
  },
}
