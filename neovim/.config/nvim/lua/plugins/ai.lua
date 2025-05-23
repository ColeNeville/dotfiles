return {
  -- nvim-aider for AI-assisted coding with Aider
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    keys = {
      { "<leader>Aa", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
      { "<leader>As", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>Ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
      { "<leader>Ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
      { "<leader>A+", "<cmd>Aider add<cr>", desc = "Add File" },
      { "<leader>A-", "<cmd>Aider drop<cr>", desc = "Drop File" },
      { "<leader>Ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
      { "<leader>AR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
      -- Integration with nvim-tree
      { "<leader>A+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>A-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
      "folke/snacks.nvim",
      -- Optional dependencies
      "nvim-tree/nvim-tree.lua", -- You already have this in your config
    },
    config = function()
      require("nvim_aider").setup({
        -- Command that executes Aider
        aider_cmd = "aider",
        -- Command line arguments passed to aider
        args = {
          "--pretty",
          "--stream",
        },
        -- Automatically reload buffers changed by Aider (requires vim.o.autoread = true)
        auto_reload = true,
        -- Other configuration options can be added as needed
        win = {
          wo = { winbar = "Aider" },
          style = "nvim_aider",
          position = "right",
        },
      })
    end,
  },
}
