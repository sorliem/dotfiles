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
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<c-y>"] = cmp.mapping(
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
        -- { name = "cmp_tabnine" },
        { name = "buffer", keyword_length = 5 },
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    }
})


local tabnine = require('cmp_tabnine.config')
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    ignored_file_types = {
        terraform = true
    }
})

vim.g.symbols_outline = {
    highlight_hovered_item = false,
    width = 50,
}

-- nvim-cmp highlight groups.
-- local Group = require("colorbuddy.group").Group
-- local g = require("colorbuddy.group").groups
-- local s = require("colorbuddy.style").styles

-- Group.new("CmpItemAbbr", g.Comment)
-- Group.new("CmpItemAbbrDeprecated", g.Error)
-- Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
-- Group.new("CmpItemKind", g.Special)
-- Group.new("CmpItemMenu", g.NonText)
