return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
      
      -- Terminal specific keymaps
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      -- Auto command to set terminal keymaps when terminal opens
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      
      -- Custom terminal functions
      local Terminal = require("toggleterm.terminal").Terminal
      
      -- Lazygit terminal
      local lazygit = Terminal:new({ 
        cmd = "lazygit", 
        hidden = true,
        direction = "float",
      })
      
      function _G.toggle_lazygit()
        lazygit:toggle()
      end
      
      -- Bottom terminal
      local bottom_term = Terminal:new({
        direction = "horizontal",
        size = 15,
      })
      
      function _G.toggle_bottom_term()
        bottom_term:toggle()
      end
      
      -- Right terminal
      local right_term = Terminal:new({
        direction = "vertical",
        size = 80,
      })
      
      function _G.toggle_right_term()
        right_term:toggle()
      end
    end,
  },
}
