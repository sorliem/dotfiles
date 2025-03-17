return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			log_level = vim.log.levels.DEBUG,
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt", "goimports", "golines" },
				terraform = { "terraform_fmt" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
				elixir = { "mix" },
				yaml = { "yamlfmt", "prettier", stop_after_first = true },
				json = { "deno_fmt", "prettier", stop_after_first = true },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
