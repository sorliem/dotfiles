return {
	{
		"tpope/vim-dadbod",
		config = function()
			require("miles.dadbod_connection_helpers").set_default_db()

			vim.api.nvim_create_user_command("DadBodDB", function()
				require("miles.dadbod_connection_helpers").change_db()
			end, { desc = "Select database for vim-dadbod" })

			vim.keymap.set("v", "<leader>db", ":DB<CR>", { desc = "Run visually selected statement against database" })
		end,
	},
}
