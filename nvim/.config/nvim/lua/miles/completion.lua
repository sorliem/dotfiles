-- setup nvim-cmp
local cmp = require('cmp')
local lspkind = require("lspkind")

local source_mapping = {
    buffer = "[buf]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[api]",
    luasnip = "[snip]",
    cmp_tabnine = "[TN]",
    path = "[path]",
}

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
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = ''
            end
            vim_item.menu = menu
            return vim_item
        end
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
