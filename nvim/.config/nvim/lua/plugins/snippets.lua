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
			vim.g.snippets = "luasnip"

			if vim.g.snippets ~= "luasnip" then
				return
			end

			local ls = require("luasnip")
			local types = require("luasnip.util.types")

			ls.config.set_config({
				history = false,
				updateevents = "TextChanged,TextChangedI",
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
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			-- <c-j> is my jump backwards key
			-- this always moves to the previous item within the snippet
			vim.keymap.set({ "i", "s" }, "<c-j>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			-- <c-l> is selecting within a list of options.
			-- This is useful for choice nodes
			vim.keymap.set("i", "<c-j>", function()
				if ls.choice_active() then
					ls.change_choice()
				end
			end)

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

			loadfile(vim.api.nvim_get_runtime_file("after/plugin/work-snippets.lua", false)[1])()
		end,
	},
}
