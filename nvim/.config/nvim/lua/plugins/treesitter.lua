-- nvim-treesitter `main` branch (required for Neovim 0.12; `master` is EOL and
-- explicitly unsupported). `main` has no `nvim-treesitter.configs` module:
-- highlighting, indentation and parser installs are wired up by hand below.
local parsers = {
	"bash",
	"diff",
	"eex",
	"elixir",
	"git_rebase",
	"gitcommit",
	"go",
	"gomod",
	"gowork",
	"gotmpl",
	"hcl",
	"heex",
	"html",
	"json",
	"json5",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"rust",
	"sql",
	"terraform",
	"toml",
	"vim",
	"vimdoc",
	"yaml",
}

local max_filesize = 2000 * 1024 -- 2Mb

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup({
						min_window_height = 50,
						max_lines = 3,
					})
				end,
			},
		},
		config = function()
			local ts = require("nvim-treesitter")

			ts.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			-- replaces `ensure_installed`; async, no-op for already-installed parsers
			ts.install(parsers)

			local wanted = {}
			for _, lang in ipairs(parsers) do
				wanted[lang] = true
			end

			-- replaces `highlight.enable` + `indent.enable`
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("miles-treesitter", { clear = true }),
				callback = function(args)
					local ft = vim.bo[args.buf].filetype
					local lang = vim.treesitter.language.get_lang(ft) or ft
					if not wanted[lang] then
						return
					end

					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > max_filesize then
						return
					end

					if not pcall(vim.treesitter.start, args.buf, lang) then
						return
					end

					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
