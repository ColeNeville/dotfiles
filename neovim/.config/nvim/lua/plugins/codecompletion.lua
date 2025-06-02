return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      sources = {
        { name = "nvim_lsp" },
      },
    },
    config = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = {
        ["<Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end
            else
              fallback()
            end
          end,
          { "i", "s", "c" }
        ),
        ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          { "i", "s", "c" }
        ),
        ["<CR>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confrim({ behaviour = cmp.ConfirmBehaviour.Replace, select = false })
            else
              fallback()
            end
          end,
          { "i", "s", "c" }
        ),
      }

      cmp.setup(opts)
    end,
  },
}
