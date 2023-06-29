return {
	{
		"tpope/vim-dadbod",
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
		},
		config = function()
			require("miles.dadbod_connection_helpers").set_default_db()

			vim.api.nvim_create_user_command("DadBodDB", function()
				require("miles.dadbod_connection_helpers").change_db()
			end, { desc = "Select database for vim-dadbod" })

			vim.keymap.set("v", "<leader>db", ":DB<CR>", { desc = "Run visually selected statement against database" })
		end,
	},
}
