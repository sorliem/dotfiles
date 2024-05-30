return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
			},
			"folke/neodev.nvim",
		},
		config = function()
			-- Use internal formatting for bindings like gq.
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					vim.bo[args.buf].formatexpr = nil
				end,
			})

			-- set up neodev before lsp stuff
			require("neodev").setup()

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
				local map = function(mode, keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
				end

				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				map("n", "gD", function()
					vim.lsp.buf.declaration()
				end, "[G]oto [d]eclaration")

				map("n", "gd", function()
					vim.lsp.buf.definition()
				end, "[G]oto [D]efinition")

				map("n", "K", function()
					vim.lsp.buf.hover()
				end, "Hover documentation")

				map("n", "gi", function()
					vim.lsp.buf.implementation()
				end, "[G]oto [I]mplementation")

				map("n", "gr", function()
					vim.lsp.buf.references()
				end, "[G]oto [R]eferences")

				-- map("i", "<C-k>", function()
				-- 	vim.lsp.buf.signature_help()
				-- end, "Signature help")

				map("n", "<space>wa", function()
					vim.lsp.buf.add_workspace_folder()
				end, "[W]orkspace [A]dd Folder")

				map("n", "<space>wr", function()
					vim.lsp.buf.remove_workspace_folder()
				end, "[W]orkspace [R]emove Folder")

				map("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")

				map("n", "<space>D", function()
					vim.lsp.buf.type_definition()
				end, "Type [D]efinition")

				map("n", "<space>rn", function()
					vim.lsp.buf.rename()
				end, "LSP [R]e[N]ame")

				map("n", "<space>rf", function()
					vim.lsp.buf.format({ async = true })
				end, "[R]un [F]ormatter")

				map("n", "<space>ca", function()
					vim.lsp.buf.code_action()
				end, "[C]ode [A]ction")

				map("n", "<space>e", function()
					vim.diagnostic.open_float()
				end, "Open floating diagnostic message")

				map("n", "]d", function()
					vim.diagnostic.goto_next()
				end, "Next diagnostic")

				map("n", "[d", function()
					vim.diagnostic.goto_prev()
				end, "Previous diagnostic")

				map("n", "<space>q", function()
					vim.diagnostic.setloclist()
				end, "Open diagnostics list")

				map("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, "Signature help")
			end

			local sumneko_binary_path = vim.fn.exepath("lua-language-server")
			local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ":h:h:h")

			local runtime_path = vim.split(package.path, ";")
			table.insert(runtime_path, "lua/?.lua")
			table.insert(runtime_path, "lua/?/init.lua")

			-- print("sumneko_root_path = " .. vim.inspect(sumneko_root_path))
			-- print("sumneko_binary_path = " .. vim.inspect(sumneko_binary_path))
			-- print("runtime_path = " .. vim.inspect(runtime_path))

			-- require("lspconfig").lua_ls.setup(config({
			-- 	cmd = { sumneko_binary_path, "-E", sumneko_root_path },
			-- 	on_attach = on_attach,
			-- 	flags = {
			-- 		debounce_text_changes = 150,
			-- 	},
			-- 	settings = {
			-- 		Lua = {
			-- 			runtime = {
			-- 				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			-- 				version = "LuaJIT",
			-- 				-- Setup your lua path
			-- 				path = runtime_path,
			-- 			},
			-- 			diagnostics = {
			-- 				-- Get the language server to recognize the `vim` global
			-- 				globals = { "vim" },
			-- 			},
			-- 			workspace = {
			-- 				-- Make the server aware of Neovim runtime files
			-- 				library = vim.api.nvim_get_runtime_file("", true),
			-- 			},
			-- 			-- Do not send telemetry data containing a randomized but unique identifier
			-- 			telemetry = {
			-- 				enable = false,
			-- 			},
			-- 		},
			-- 	},
			-- }))

			require("lspconfig").lua_ls.setup(config({
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

			require("lspconfig").pylsp.setup(config({
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				},
			}))

			require("lspconfig").terraformls.setup(config({
				on_attach = on_attach,
				cmd = { "terraform-ls", "serve", "--log-file", "/tmp/terraform-lsp.log" },
				flags = {
					debounce_text_changes = 150,
				},
			}))

			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				pattern = { "*.tf", "*.tfvars" },
				callback = function()
					vim.lsp.buf.format()
				end,
			})

			require("lspconfig").tflint.setup(config({
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				},
			}))

			-- require("lspconfig").elixirls.setup(config({
			-- 	on_attach = on_attach,
			-- 	cmd = { "/home/miles/bin/elixirls/language_server.sh" },
			-- 	flags = {
			-- 		debounce_text_changes = 150,
			-- 	},
			-- }))

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

			require("lspconfig").tailwindcss.setup(config({
				on_attach = on_attach,
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
