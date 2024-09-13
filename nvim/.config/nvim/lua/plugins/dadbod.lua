return {
	{
		"tpope/vim-dadbod",
		-- cmd = {
		-- 	"DBUI",
		-- },
		dependencies = {
			{
				"kristijanhusak/vim-dadbod-completion",
				config = function()
					vim.cmd([[
						augroup DadbodSql
							au!
							autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
						augroup END
					]])
				end,
			},
			{
				"kristijanhusak/vim-dadbod-ui",
				cmd = {
					"DBUI",
					"DBUIToggle",
					"DBUIAddConnection",
					"DBUIFindBuffer",
				},
				init = function()
					-- Your DBUI configuration
					vim.g.db_ui_use_nerd_fonts = 1
				end,
			},
		},
		config = function()
			-- see ~/.config/nvim/lua/miles/dadbod_connection_helpers.lua
			require("miles.dadbod_connection_helpers").set_default_db()

			vim.api.nvim_create_user_command("DadBodDB", function()
				require("miles.dadbod_connection_helpers").change_db()
			end, { desc = "Select database for vim-dadbod" })

			vim.keymap.set(
				"v",
				"<leader>db",
				"<cmd>DB<CR>",
				{ desc = "Run visually selected statement against database" }
			)

			vim.keymap.set("n", "<leader>ds", function()
				require("miles.dadbod_connection_helpers").change_db()
			end, { desc = "[D]adbod [s]witch db with telescope" })
		end,
	},
}
