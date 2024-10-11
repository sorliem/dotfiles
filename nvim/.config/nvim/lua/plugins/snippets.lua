return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		-- event = { "InsertEnter" },
		config = function()
			-- vim.g.snippets = "luasnip"
			--
			-- if vim.g.snippets ~= "luasnip" then
			-- 	return
			-- end

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

			-- <c-l> is selecting within a list of options.
			-- This is useful for choice nodes
			-- vim.keymap.set("i", "<c-j>", function()
			-- 	if ls.choice_active() then
			-- 		ls.change_choice()
			-- 	end
			-- end)

			-- require("luasnip.loaders.from_vscode").lazy_load()

			-- add html snips to elixir templates
			require("luasnip").filetype_extend("eelixir", { "html" })
			require("luasnip").filetype_extend("nginx", { "lua" })

			-- add terraform snippets
			-- require("luasnip").filetype_extend("terraform", { "terraform" })

			-- local source_external_snippets = function()
			-- 	-- loadfile(vim.api.nvim_get_runtime_file("lua/plugins/snippets.lua", false)[1])
			-- 	loadfile(vim.api.nvim_get_runtime_file("after/plugin/work-snippets.lua", false)[1])()
			-- end

			-- vim.keymap.set("n", "<Leader>rs", function()
			-- 	ls.cleanup()
			-- 	source_external_snippets()
			-- 	print("dumped and reloaded snippets")
			-- end, { desc = "[R]eload [S]nippets", noremap = true, silent = true })

			-- set keybinds for both INSERT and VISUAL.
			vim.keymap.set("i", "<C-n>", "<Plug>luasnip-next-choice")
			vim.keymap.set("s", "<C-n>", "<Plug>luasnip-next-choice")
			vim.keymap.set("i", "<C-p>", "<Plug>luasnip-prev-choice")
			vim.keymap.set("s", "<C-p>", "<Plug>luasnip-prev-choice")

			-- ~/.config/nvim/after/plugin/work-snippets.lua
			loadfile(vim.api.nvim_get_runtime_file("after/plugin/work-snippets.lua", false)[1])()
		end,
	},
}
