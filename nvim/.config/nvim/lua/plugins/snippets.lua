return {
	{
		"L3MON4D3/LuaSnip",
		-- event = "VeryLazy",
		-- {
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = {
			{
				"hrsh7th/nvim-cmp",
			},
			{
				"saadparwaiz1/cmp_luasnip",
			},
			-- "rafamadriz/friendly-snippets",
		},
		config = function()
			vim.opt.shortmess:append("c") -- see :h shm-c

			local ls = require("luasnip")
			local types = require("luasnip.util.types")

			vim.snippet.expand = ls.lsp_expand

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.active = function(filter)
				filter = filter or {}
				filter.direction = filter.direction or 1

				if filter.direction == 1 then
					return ls.expand_or_jumpable()
				else
					return ls.jumpable(filter.direction)
				end
			end

			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.jump = function(direction)
				if direction == 1 then
					if ls.expandable() then
						return ls.expand_or_jump()
					else
						return ls.jumpable(1) and ls.jump(1)
					end
				else
					return ls.jumpable(-1) and ls.jump(-1)
				end
			end

			ls.setup({
				-- history = false,
				update_events = "TextChanged,TextChangedI",
				enable_autosnippets = true,
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { " « CHOICE " } },
							hl_group = "GruvboxBlue",
						},
						unvisited = {
							hl_group = "GruvboxGreen",
						},
					},
				},
			})

			for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
				loadfile(ft_path)()
			end

			-- <c-k> is my expansion key
			-- this will expand the current item or jump to the next item within the snippet.
			vim.keymap.set({ "i", "s" }, "<c-k>", function()
				return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
				-- if ls.expand_or_jumpable() then
				-- 	ls.expand_or_jump()
				-- end
			end, { silent = true })

			-- <c-j> is my jump backwards key
			-- this always moves to the previous item within the snippet
			vim.keymap.set({ "i", "s" }, "<c-j>", function()
				return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
			end, { silent = true })

			-- require("luasnip.loaders.from_vscode").lazy_load()

			-- extend snippet filetypes
			require("luasnip").filetype_extend("eelixir", { "html" })
			require("luasnip").filetype_extend("nginx", { "lua" })

			-- set keybinds for both INSERT and VISUAL.
			vim.keymap.set("i", "<C-n>", "<Plug>luasnip-next-choice")
			vim.keymap.set("s", "<C-n>", "<Plug>luasnip-next-choice")
			vim.keymap.set("i", "<C-p>", "<Plug>luasnip-prev-choice")
			vim.keymap.set("s", "<C-p>", "<Plug>luasnip-prev-choice")

			-- Ignored file: ~/.config/nvim/after/plugin/work-snippets.lua
			loadfile(vim.api.nvim_get_runtime_file("after/plugin/work-snippets.lua", false)[1])()
		end,
	},
}
