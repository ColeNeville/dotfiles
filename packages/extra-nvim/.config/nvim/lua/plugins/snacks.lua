return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>pp",
      function()
        Snacks.picker.projects({})
      end,
      desc = "Find Project",
    },
    {
      "<leader>bb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find Open Buffer",
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
        projects = {
          dev = {
            "~",
            "~/projects",
            "~/**/projects", -- Glob doesn't work, I need to confirm with project
            "~/projects/monorail/projects",
            "~/dev",
            "~/**/dev", -- Glob doesn't work, I need to confirm with project
          },
          patterns = {
            ".git",
            "package.json", -- NPM
            "Gemfile", -- Ruby
            "Makefile",
          },
        },
      },
    },
  },
}
