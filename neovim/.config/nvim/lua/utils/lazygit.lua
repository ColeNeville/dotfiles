local Terminal = require('toggleterm.terminal').Terminal

local M = {}

function M.toggle_lazygit_float()
  if not _G.lazygit_terminals then
    _G.lazygit_terminals = {}
  end

  local terminals = _G.lazygit_terminals

  local current_cwd = vim.fn.getcwd()
  local term_obj = terminals[current_cwd]

  -- If a terminal object for the current CWD doesn't exist in our map,
  -- (e.g., first time, or lazygit exited and on_close cleared the map entry)
  -- then create a new one.
  if not terminal then
    terminal = Terminal:new({
      cmd = "lazygit",
      dir = current_cwd, -- Run lazygit in the current working directory
      hidden = true,     -- Create it hidden
      -- on_close is crucial for cleaning up the map entry
      -- when the terminal is closed or lazygit exits.
      on_close = function(closed_term)
        -- Only remove from map if the closed terminal is the one we stored
        if terminals[current_cwd] == closed_term then
          terminals[current_cwd] = nil
        end
      end,
    })

    -- Store the newly created terminal object in our map
    terminals[current_cwd] = terminal
  end

  -- Now, term_obj refers to an existing terminal object:
  -- - If it was just created, it's hidden, so toggle() will show it.
  -- - If it existed and was open, toggle() will hide it.
  terminal:toggle()
end

return M
