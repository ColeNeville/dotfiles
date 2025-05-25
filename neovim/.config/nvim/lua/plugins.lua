-- neovim/.config/nvim/lua/plugins.lua

return {
  -- which-key.nvim: For displaying keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- Load when needed
    opts = {
      -- Minimal options:
      -- This filter will hide keymaps that don't have a 'desc' field,
      -- keeping the which-key popup clean.
      filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
      end,
      -- Most other settings will use which-key's defaults.
      -- You can add more specific 'opts' here later if needed.
      -- For example, to customize the window appearance:
      -- window = {
      --   border = "rounded", -- 'none', 'single', 'double', 'shadow', 'rounded'
      -- },
      -- To enable built-in presets for common Vim commands:
      -- presets = {
      --   operators = true,
      --   motions = true,
      --   text_objects = true,
      --   windows = true,
      --   nav = true,
      --   z = true,
      --   g = true,
      -- },
    },
    keys = {
      -- Example keymap provided by which-key for buffer-local mappings
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
  },

  -- nvim-tree.lua: File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*", -- Pin to latest stable release
    lazy = false,  -- Load on startup
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- For file icons (recommended for default experience)
    },
    config = function()
      -- Disable netrw, as nvim-tree will be the file explorer
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Call setup with an empty table to ensure default settings are applied.
      -- nvim-tree generally works well with its defaults.
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
      })
    end,
    keys = {
      -- These keymaps are defined here so lazy.nvim manages them.
      -- Adding a 'desc' field will make them show up in which-key.
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", mode = "n", noremap = true, silent = true, desc = "Toggle Explorer (nvim-tree)" },
      { "<leader>Ee", "<cmd>NvimTreeOpen ~<CR>", mode = "n", noremap = true, silent = true, desc = "Open Home Directory (nvim-tree)" },
    },
  },

  -- Colorscheme: gruvbox.nvim
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Make sure to load this before all other start plugins
    lazy = false,    -- Load on startup
    config = function()
      -- Load the colorscheme here.
      -- For a skeleton, we use default settings for gruvbox.
      require("gruvbox").setup({})
      vim.cmd.colorscheme "gruvbox"
    end,
  },

  -- Utility library for Neovim plugins
  {
    "nvim-lua/plenary.nvim",
    lazy = true, -- Will be loaded when Telescope or other plugins need it
  },

  -- Fuzzy Finder: Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x", -- Recommended to use a stable tag, e.g., "0.1.6" or check latest
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        -- Minimal Telescope setup. Defaults are generally good.
        defaults = {
          -- You can add default options here if needed, e.g.:
          -- file_ignore_patterns = { "%.git/", "node_modules/" },
        },
        -- extensions = {
        --   -- Extensions can be configured here if needed after loading
        -- }
      })
      -- Extensions are typically loaded after the providing plugin is also configured.
      -- We will load the 'projects' extension in project.nvim's config.
    end,
    keys = {
      {
        "<leader>ff",
        function()
          require('telescope.builtin').find_files({ hidden = true })
        end,
        desc = "Find Files (Telescope)", mode = "n", noremap = true, silent = true,
      },
    },
  },

  -- Project Management: project.nvim
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy", -- Changed from no event to VeryLazy
    dependencies = { "nvim-telescope/telescope.nvim" }, -- Ensures telescope is available
    config = function()
      require("project_nvim").setup({
        -- Using default settings for project.nvim for a skeleton.
        -- You can customize detection_methods, patterns, manual_mode, etc. later.
        -- For example:
        -- manual_mode = false,
        -- detection_methods = { "lsp", "pattern" },
        -- patterns = { ".git", "Makefile", "package.json" },
      })
      -- Load the Telescope extension provided by project.nvim.
      -- This should be done after both telescope and project_nvim have been set up.
      pcall(require('telescope').load_extension, 'projects')
    end,
    keys = {
      {
        "<leader>pp",
        function()
          require('telescope').extensions.projects.projects{}
        end,
        desc = "Open Project (project.nvim)", mode = "n", noremap = true, silent = true,
      },
    },
  },

  -- Add other plugins here:
  -- e.g.
  -- { "nvim-lua/plenary.nvim" }, -- Utility functions
  -- { "nvim-telescope/telescope.nvim", tag = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },

  -- You can also group plugins into files, e.g., lua/plugins/ui.lua, lua/plugins/lsp.lua
  -- and then import them here:
  -- require("plugins.ui"),
  -- require("plugins.lsp"),

  -- Aider: AI coding assistant integration
  {
    "joshuavial/aider.nvim",
    opts = {
      -- Using default settings as per the plugin's README
      auto_manage_context = true, -- automatically manage buffer context
      default_bindings = false,   -- use default <leader>A keybindings
      debug = false,              -- enable debug logging
      -- You can customize further options here if needed, e.g., 'border'
    },
  },
}
