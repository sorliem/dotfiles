-- mason-org/* (williamboman/* is archived). mason.nvim 2.x + mason-lspconfig 2.x
-- require Neovim >= 0.11 and nvim-lspconfig >= 2.0.0.
return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig", -- required by mason-lspconfig 2.x
		},
		-- NOTE: the previous spec used a `setup =` key, which lazy.nvim ignores,
		-- so ensure_installed never actually ran.
		opts = {
			-- 2.x takes lspconfig server names, not mason package names
			ensure_installed = {
				"dockerls",
				-- gopls is managed by the go toolchain (~/go/bin), not mason
				"jsonls",
				"lua_ls",
				"marksman",
				"pylsp",
				"tailwindcss",
				"tflint",
				"yamlls",
			},
			-- lua/miles/lsp.lua owns which servers are enabled via vim.lsp.enable();
			-- mason has plenty of other servers installed that must stay off.
			automatic_enable = false,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			-- non-LSP tools backing conform.nvim and nvim-lint; mason.nvim 2.x has
			-- no ensure_installed of its own and mason-lspconfig only takes servers
			ensure_installed = {
				"commitlint",
				"goimports",
				"golines",
				"hadolint",
				"prettier",
				"prettierd",
				"stylua",
				"vale",
			},
			run_on_start = false, -- run :MasonToolsInstall by hand
		},
	},
}
