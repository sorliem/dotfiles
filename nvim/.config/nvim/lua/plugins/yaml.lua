return {
	{
		"cuducos/yaml.nvim",
		event = "VeryLazy",
		ft = { "yaml", "template" }, -- optional
		config = function()
			-- require("lualine").setup({
			-- 	sections = {
			-- 		lualine_z = { require("yaml_nvim").get_yaml_key_and_value },
			-- 	},
			-- })
		end,
	},
}
