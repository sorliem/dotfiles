return {
	{
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init({
				mode = "symbol_text",
			})
		end,
	},
}
