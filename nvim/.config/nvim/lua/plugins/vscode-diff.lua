return {
	"esmuellert/codediff.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		vim.keymap.set("n", "<leader>cd", ":CodeDiff<CR>", { desc = "VS [C]ode [D]iff" })
	end,
}
