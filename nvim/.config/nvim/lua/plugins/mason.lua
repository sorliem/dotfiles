return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		setup = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"commitlint",
					"dockerfile-language-server",
					"lua-language-server",
					"prettier",
					"python-lsp-server",
					"stylua",
					"tailwindcss-language-server",
					"terraform-ls",
					"tflint",
					"vale",
					"vls",
					"yaml-language-server",
				},
			})
		end,
	},
}
