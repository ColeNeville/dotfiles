return {
  "rmagatti/auto-session",
  keys = {
    {
      "<leader>sS",
      function()
        require('auto-session.session-lens')
            .search_session()
      end,
      desc = "Search sessions (Auto Session)",
    },
  },
  opts = {
    auto_session_supress_dirs = { "~/", "/" },
    session_lens = {
      buftypes_to_ignore = {},
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
    },
  },
}
