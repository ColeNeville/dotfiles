-- neovim/.config/nvim/lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- Load when needed
  opts = {
    preset = "helix",
    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ""
    end,
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
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Show Buffer Local Keymaps (which-key)",
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
    -- Load custom which-key registrations (groups, etc.)
    require("config.keymaps")
  end,
}
