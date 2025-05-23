return {
  -- nvim-aider for AI-assisted coding with Aider
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    keys = {
      { "<leader>Aa", function() vim.cmd("Aider toggle") end, desc = "Toggle Aider" },
      { "<leader>As", function() vim.cmd("Aider send") end, desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>Ac", function() vim.cmd("Aider command") end, desc = "Aider Commands" },
      { "<leader>Ab", function() vim.cmd("Aider buffer") end, desc = "Send Buffer" },
      { "<leader>A+", function() vim.cmd("Aider add") end, desc = "Add File" },
      { "<leader>A-", function() vim.cmd("Aider drop") end, desc = "Drop File" },
      { "<leader>Ar", function() vim.cmd("Aider add readonly") end, desc = "Add Read-Only" },
      { "<leader>AR", function() vim.cmd("Aider reset") end, desc = "Reset Session" },
      -- Integration with nvim-tree
      { "<leader>A+", function() vim.cmd("AiderTreeAddFile") end, desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>A-", function() vim.cmd("AiderTreeDropFile") end, desc = "Drop File from Tree from Aider", ft = "NvimTree" },
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
