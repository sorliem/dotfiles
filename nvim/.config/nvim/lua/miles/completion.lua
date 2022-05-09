-- setup nvim-cmp
local cmp = require('cmp')
local lspkind = require("lspkind")
lspkind.init()

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          { "i", "c" }
        ),
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    },

    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                luasnip = "[snip]",
                cmp_tabnine = "[TN]",
                path = "[path]",
            }
        }
    },

    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer", keyword_length = 5 },
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    }
})

-- vim.g.symbols_outline = {
--     highlight_hovered_item = false,
--     width = 50,
-- }
