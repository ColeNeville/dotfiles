-- neovim/.config/nvim/lua/config/keymaps.lua

local wk = require("which-key")

wk.add({
  { mode = { "n" }, -- Default mode for these registrations
    -- Group definitions for plugin-based bindings.
    -- Their actual keybindings (<leader>Ee, <leader>ff, <leader>pp) are defined in plugins.lua.
    -- and will be automatically associated by which-key due to the shared prefix and 'desc' attribute.
    { "<leader>E", group = "Explorer" },
    { "<leader>f", group = "File" },
    {
      "<leader>ff",
      function () require('telescope.builtin').find_files({}) end,
      desc = "telescope: Find files"
    },

    { "<leader>p", group = "Project" },
    {
      "<leader>pp",
      function()
        require('telescope').extensions.projects.projects{}
      end,
      desc = "Open Project (project.nvim)",
    },

    { "<leader>b", group = "Buffers" },
    {
      "<leader>bb",
      function () require('telescope.builtin').buffers({}) end,
      desc = "Telescope: Search buffers",
    },

    { "<leader>s" , desc = "Sessions" },
    {
      "<leader>ss",
      function() require('auto-session.session-lens').search_session() end,
      desc = "Auto Session: Search sessions",
    },

    -- Define <leader>q as a group
    { "<leader>q", group = "Quit" },
    -- Define the actual keybindings that will fall under the <leader>q group
    { "<leader>qq", "<cmd>quitall<cr>", desc = "Quit All (Safe)" },
    { "<leader>qQ", "<cmd>quitall!<cr>", desc = "Quit All (Force)" },

    { "<leader>A", group = "AI" }, -- Group for Aider commands
    {
      "<leader>Aa",
      "<cmd>Aider toggle<cr>",
      desc = "Aider: Toggle",
    },
    {
      "<leader>As",
      "<cmd>Aider send<cr>",
      desc = "Aider: Send",
      mode = {"n", "v"},
    },
    {
      "<leader>Af",
      "<cmd>Aider add<cr>", -- Adds the current buffer's file
      desc = "Aider: Add file to context",
    },
    {
      "<leader>Ab",
      "<cmd>Aider buffer<cr>",
      desc = "Aider: Add buffer to context",
    },
    {
      "<leader>Ac",
      "<cmd>Aider command<cr>",
      desc = "Run command (nvim-aider)",
    },
    {
      "<leader>AR",
      "<cmd>Aider reset<cr>",
      desc = "Reset session (nvim-aider)",
    },

    -- Define <leader>t as a group for Toggles
    { "<leader>t", group = "Toggle" },
    -- Define the actual keybindings that will fall under the <leader>t group
    {
      "<leader>tw",
      function()
        vim.opt.wrap = not vim.opt.wrap:get()
        if vim.opt.wrap:get() then
          print("Word wrap enabled")
        else
          print("Word wrap disabled")
        end
      end,
      desc = "Word Wrap",
    },
    {
      "<leader>td",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Trouble: Buffer Diagnostics",
    },

    { "<leader>l", group = "LSP" },
    {
      "<leader>lm",
      "<cmd>:Mason<cr>",
      desc = "Mason: Show",
    },
  },
  -- You can add other groups or individual keymaps here, for example:
  -- {
  --   mode = { "n" },
  --   { "<leader>s", group = "Search" },
  --   { "<leader>sg", "<cmd> Telescope live_grep <cr>", desc = "Live Grep" },
  -- }

  {
    "<leader>?",
    function() require("which-key").show({ global = false }) end,
    desc = "Show Buffer Local Keymaps (which-key)",
  },
})

-- If you still want to use vim.keymap.set for some other global keybindings, you can do so here:
-- local keymap = vim.keymap.set
-- local opts = { noremap = true, silent = true }
-- keymap("n", "<leader>xy", "<cmd>echo 'Other mapping'<cr>", { desc = "Other Mapping", noremap = true, silent = true })
