return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>pp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Open Project",
    },
  },
  opts = {
    picker = {
      hidden = true,
      ignored = true,
      sources = {
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
