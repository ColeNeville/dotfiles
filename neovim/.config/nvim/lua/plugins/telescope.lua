-- neovim/.config/nvim/lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    mode = { "n" },
    {
      "<leader>lR",
      function()
        require('telescope.builtin')
            .lsp_references()
      end,
      desc = "Show references (Telescope)"
    },
    {
      "<leader>li",
      function()
        require('telescope.builtin')
            .lsp_implementations()
      end,
      desc = "Show implementations (Telescope)"
    },
    {
      "<leader>ls",
      function()
        require('telescope.builtin')
            .lsp_document_symbols()
      end,
      desc = "Show document symbols (Telescope)"
    },
    {
      "<leader>lS",
      function()
        require('telescope.builtin')
            .lsp_workspace_symbols()
      end,
      desc = "Show workspace symbols (Telescope)"
    },
    {
      "<leader>ff",
      function()
        require('telescope.builtin')
            .find_files({})
      end,
      desc = "Find files (Telescope)"
    },
    {
      "<leader>fr",
      function()
        require('telescope.builtin')
            .oldfiles()
      end,
      desc = "Recent files (Telescope)"
    },
    {
      "<leader>pp",
      function()
        require('telescope')
            .extensions
            .projects
            .projects({})
      end,
      desc = "Switch project (Project)",
    },
    {
      "<leader>bb",
      function()
        require('telescope.builtin')
            .buffers({})
      end,
      desc = "Search buffers (Telescope)",
    },
    {
      "<leader>sd",
      function()
        require('telescope.builtin')
            .live_grep()
      end,
      desc = "Search in directory (Telescope)",
    },
    {
      "<leader>sw",
      function()
        require('telescope.builtin')
            .grep_string()
      end,
      desc = "Search word under cursor (Telescope)"
    },
    {
      "<leader>sh",
      function()
        require('telescope.builtin')
            .help_tags()
      end,
      desc = "Search help (Telescope)"
    },
    {
      "<leader>sk",
      function()
        require('telescope.builtin')
            .keymaps()
      end,
      desc = "Search keymaps (Telescope)"
    },
    {
      "<leader>sc",
      function()
        require('telescope.builtin')
            .command_history()
      end,
      desc = "Search command history (Telescope)"
    },
    {
      "<leader>sr",
      function()
        require('telescope.builtin')
            .resume()
      end,
      desc = "Resume last search (Telescope)"
    },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        vimgrep_arguments = {
          "--hidden",
          "--glob",
          "!**/.git/*",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!**/.git/*"
          },
        },
      },
    })
  end,
}
