return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-emoji",
		},
		config = function()
			local cmp = require("cmp")
			local cmp_buffer = require("cmp_buffer")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					-- ["<C-n>"] = cmp.mapping.select_next_item(),
					-- ["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<C-y>"] = cmp.mapping(
						cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}),
						{ "i", "c" }
					),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					expandable_indicator = true,
					format = require("lspkind").cmp_format({
						mode = "symbol_text",
						maxwidth = function()
							return math.floor(0.45 * vim.o.columns)
						end,
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default
						with_text = true,
						menu = {
							buffer = "[buf]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[lua]",
							luasnip = "[snip]",
							cmp_tabnine = "[TN]",
							path = "[path]",
							["vim-dadbod-completion"] = "[DB]",
						},
					}),
				},

				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip", max_item_count = 10 },
					{
						name = "buffer",
						keyword_length = 2,
						max_item_count = 7,
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					{ name = "emoji" },
					{ name = "path" },
				},
				sorting = {
					priority_weight = 1,
					comparators = {
						function(...)
							-- sort completion results based on the distance of the word from the cursor line
							return cmp_buffer:compare_locality(...)
						end,
					},
				},
				experimental = {
					native_menu = false,
					ghost_text = false,
				},
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!", "write", "quit", "global" },
						},
					},
				}),
			})
		end,
	},
}
