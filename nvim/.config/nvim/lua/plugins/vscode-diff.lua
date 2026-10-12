return {
	"esmuellert/codediff.nvim",
	keys = {
		{ "<leader>cd" },
	},
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		vim.keymap.set("n", "<leader>cd", ":CodeDiff<CR>", { desc = "VS [C]ode [D]iff" })
	end,
}
