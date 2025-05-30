return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float", -- Global defaults can be set here
    float_opts = {
      border = "rounded",
    },
    -- close_on_exit = true,
  },
  config = function(_, opts)
    local toggleterm_module = require('toggleterm')
    local Terminal = require('toggleterm.terminal').Terminal

    toggleterm_module.setup(opts)

    -- Initialize the global map for lazygit terminals if it doesn't exist
    if not _G.lazygit_terminals_map then
      _G.lazygit_terminals_map = {}
    end

    _G.toggle_lazygit_float = function()
      local current_cwd = vim.fn.getcwd()
      local term_obj = _G.lazygit_terminals_map[current_cwd]

      -- If a terminal object for the current CWD doesn't exist in our map,
      -- (e.g., first time, or lazygit exited and on_close cleared the map entry)
      -- then create a new one.
      if not term_obj then
        term_obj = Terminal:new({
          cmd = "lazygit",
          dir = current_cwd,    -- Run lazygit in the current working directory
          hidden = true,        -- Create it hidden
          -- on_close is crucial for cleaning up the map entry
          -- when the terminal is closed or lazygit exits.
          on_close = function(closed_term)
            -- Only remove from map if the closed terminal is the one we stored
            if _G.lazygit_terminals_map and _G.lazygit_terminals_map[current_cwd] == closed_term then
              _G.lazygit_terminals_map[current_cwd] = nil
            end
          end,
        })
        -- Store the newly created terminal object in our map
        _G.lazygit_terminals_map[current_cwd] = term_obj
      end

      -- Now, term_obj refers to an existing terminal object:
      -- - If it was just created, it's hidden, so toggle() will show it.
      -- - If it existed and was open, toggle() will hide it.
      term_obj:toggle()
    end
  end,
}
