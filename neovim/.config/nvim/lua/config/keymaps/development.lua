-- neovim/.config/nvim/lua/config/keymaps/development.lua
-- LSP, language tools, and development-related keymaps

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Normal mode keymaps

    -- ================================================================
    -- LSP & LANGUAGE TOOLS
    -- ================================================================
    { "<leader>l", group = "LSP & Language Tools" },
    {
      "<leader>lm",
      "<cmd>Mason<cr>",
      desc = "Open package manager (Mason)",
    },
    {
      "<leader>lf",
      function() vim.lsp.buf.format() end,
      desc = "Format buffer (LSP)"
    },
    {
      "<leader>la",
      function() vim.lsp.buf.code_action() end,
      desc = "Code actions (LSP)"
    },
    {
      "<leader>lr",
      function() vim.lsp.buf.rename() end,
      desc = "Rename symbol (LSP)"
    },
    {
      "<leader>ld",
      function() vim.lsp.buf.definition() end,
      desc = "Go to definition (LSP)"
    },
    {
      "<leader>lh",
      function() vim.lsp.buf.hover() end,
      desc = "Show hover info (LSP)"
    },
    {
      "<leader>lR",
      function() require('telescope.builtin').lsp_references() end,
      desc = "Show references (Telescope)"
    },
    {
      "<leader>li",
      function() require('telescope.builtin').lsp_implementations() end,
      desc = "Show implementations (Telescope)"
    },
    {
      "<leader>ls",
      function() require('telescope.builtin').lsp_document_symbols() end,
      desc = "Show document symbols (Telescope)"
    },
    {
      "<leader>lS",
      function() require('telescope.builtin').lsp_workspace_symbols() end,
      desc = "Show workspace symbols (Telescope)"
    },
    {
      "<leader>lt",
      function() vim.lsp.buf.type_definition() end,
      desc = "Go to type definition (LSP)"
    },
  },
})
