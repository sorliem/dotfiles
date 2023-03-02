return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"j-hui/fidget.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local function config(_config)
				return vim.tbl_deep_extend("force", {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				}, _config or {})
			end

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(_, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
				end

				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "[G]oto [d]eclaration")
				nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "[G]oto [D]efinition")
				nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover documentation")
				nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "[G]oto [I]mplementation")
				nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "[G]oto [R]eferences")
				-- nmap('<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', "Signature help")
				nmap("<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "[W]orkspace [A]dd Folder")
				nmap("<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "[W]orkspace [R]emove Folder")
				nmap(
					"<space>wl",
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					"[W]orkspace [L]ist Folders"
				)
				nmap("<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type [D]efinition")
				nmap("<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP [R]e[N]ame")
				nmap("<space>rf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "[R]un [F]ormatter")
				nmap("<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "[C]ode [A]ction")
				nmap("<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", "Open floating diagnostic message")
				nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic")
				nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic")
				nmap("<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", "Open diagnostics list")
				vim.keymap.set("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
			end

			local sumneko_binary_path = vim.fn.exepath("lua-language-server")
			local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ":h:h:h")

			local runtime_path = vim.split(package.path, ";")
			table.insert(runtime_path, "lua/?.lua")
			table.insert(runtime_path, "lua/?/init.lua")

			require("lspconfig").lua_ls.setup(config({
				cmd = { sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua" },
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				},
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
							-- Setup your lua path
							path = runtime_path,
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			}))

			require("lspconfig").rust_analyzer.setup(config({
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				},
			}))

			require("lspconfig").vuels.setup(config({
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				},
			}))

			require("lspconfig").tsserver.setup(config({
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				},
			}))

			require("lspconfig").terraformls.setup(config({
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				},
			}))

			require("lspconfig").elixirls.setup(config({
				on_attach = on_attach,
				cmd = { "/home/miles/bin/elixirls/language_server.sh" },
				flags = {
					debounce_text_changes = 150,
				},
			}))

			require("lspconfig").gopls.setup(config({
				cmd = { "gopls", "serve" },
				on_attach = on_attach,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
				flags = {
					debounce_text_changes = 150,
				},
			}))

			require("fidget").setup({
				text = {
					spinner = "dots",
				},
				window = {
					relative = "win",
					blend = 0,
				},
			})
		end,
	},
}
