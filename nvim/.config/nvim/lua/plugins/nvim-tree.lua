return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()

			vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", { desc = "[N]vimTree [T]oggle" })
		end,
	},
}
