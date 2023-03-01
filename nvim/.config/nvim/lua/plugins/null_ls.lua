return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			debug = true,
			sources = {
				null_ls.builtins.diagnostics.write_good,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.stylua,
			},
			on_attach = function(client, bufnr)
				print(
					"in on_attach supports formatting?: " .. tostring(client.supports_method("textDocument/formatting"))
				)
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
