return {
  -- Keymapping
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load when needed
    opts = {
      preset = "helix",
      win = {
        no_overlap = true,
        border = "rounded",
      },
      plugins = {
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      -- Load custom which-key registrations (groups, etc.)
      require("config.keymaps")
    end,
  },
  -- Terminal Emulator
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      mode = { "n" },
      {
        "<leader>gg",
        function()
          require("utils.lazygit")
              .toggle_lazygit_float()
        end,
        desc = "Open Lazygit (ToggleTerm)",
      },
    },
    opts = {
      direction = "float", -- Global defaults can be set here
      float_opts = {
        border = "rounded",
      },
      -- close_on_exit = true,
    },
  },
}
