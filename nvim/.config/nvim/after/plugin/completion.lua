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
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
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
        {
            name = "buffer",
            keyword_length = 2,
            max_item_count = 7,
            option = {
                -- allow completion of words in visible windows, not just current buffer
                get_bufnrs = function()
                    local bufs = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        bufs[vim.api.nvim_win_get_buf(win)] = true
                    end
                    return vim.tbl_keys(bufs)
                end
            }
        },
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    }
})
