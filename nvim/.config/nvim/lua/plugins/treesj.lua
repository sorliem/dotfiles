return {
	"Wansmer/treesj",
	-- keys = { "<space>m", "<space>j", "<space>s" },
	dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
	event = "VeryLazy",
	cond = false,
	config = function()
		require("treesj").setup({ --[[ your config ]]
			use_default_keymaps = false,
		})
	end,
}
