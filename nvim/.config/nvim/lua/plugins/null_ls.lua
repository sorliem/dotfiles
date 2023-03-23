return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("NullLS_LspFormatting", {})

		null_ls.setup({
			debug = true,
			sources = {
				null_ls.builtins.diagnostics.vale.with({
					filetypes = { "markdown", "graphql", "text" },
				}),
				null_ls.builtins.formatting.goimports,
				-- null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.rustfmt,
				null_ls.builtins.code_actions.gitsigns,
				-- null_ls.builtins.formatting.terraform_fmt.with({
				-- 	async = true,
				-- }),
				-- null_ls.builtins.diagnostics.yamlfmt,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
}
