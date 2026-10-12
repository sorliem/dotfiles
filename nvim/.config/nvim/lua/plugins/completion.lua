-- blink.cmp replaces nvim-cmp (upstream unmaintained). Source parity with the
-- old cmp setup: lsp / path / buffer / luasnip / signature-help / nvim_lua
-- (via lazydev) / git / emoji, plus cmdline completion.
return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"L3MON4D3/LuaSnip",
			"folke/lazydev.nvim",
			"Kaiser-Yang/blink-cmp-git",
			"moyiz/blink-emoji.nvim",
		},
		opts = {
			snippets = { preset = "luasnip" },

			-- keys match the previous nvim-cmp bindings
			keymap = {
				preset = "none",
				["<C-y>"] = { "select_and_accept" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				-- `fallback` keeps luasnip's <C-n>/<C-p> choice-node cycling working
				-- when the menu is closed (see lua/plugins/snippets.lua)
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			completion = {
				list = {
					-- mimics cmp's noselect + SelectBehavior.Insert
					selection = { preselect = false, auto_insert = true },
				},
				menu = {
					max_height = 15,
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
			},

			-- replaces cmp-nvim-lsp-signature-help
			signature = { enabled = true },

			sources = {
				default = { "lsp", "path", "snippets", "buffer", "lazydev", "git", "emoji" },
				providers = {
					-- replaces cmp-nvim-lua
					lazydev = {
						name = "lazydev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
					-- replaces cmp-git
					git = {
						name = "git",
						module = "blink-cmp-git",
						enabled = function()
							return vim.tbl_contains({ "gitcommit", "markdown", "octo" }, vim.bo.filetype)
						end,
						opts = {},
					},
					-- replaces cmp-emoji
					emoji = {
						name = "emoji",
						module = "blink-emoji",
						score_offset = 15,
						opts = { insert = true },
					},
					buffer = {
						min_keyword_length = 3,
						max_items = 7,
						opts = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					snippets = { max_items = 10 },
				},
			},

			cmdline = {
				keymap = {
					preset = "cmdline",
					["<C-y>"] = { "select_and_accept" },
					["<C-n>"] = { "select_next", "fallback" },
					["<C-p>"] = { "select_prev", "fallback" },
					["<C-e>"] = { "hide", "fallback" },
				},
				completion = {
					menu = { auto_show = true },
					list = { selection = { preselect = false, auto_insert = true } },
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
