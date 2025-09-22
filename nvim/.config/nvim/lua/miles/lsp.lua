local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.bo[args.buf].formatexpr = nil
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(_, bufnr)
	local map = function(mode, keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
	end

	map("n", "gd", function()
		vim.lsp.buf.definition()
	end, "[G]oto [D]efinition")

	map("n", "<space>q", function()
		vim.diagnostic.setloclist()
	end, "Open diagnostics list")

	map("n", "<space>e", function()
		vim.diagnostic.open_float()
	end, "Open floating diagnostic message")

	map("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, "Next diagnostic")

	map("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, "Previous diagnostic")
end

vim.lsp.config("*", {
	root_markers = { ".git" },
})

local lsp_configs = {
	lua_ls = {
		on_attach = on_attach,
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
	},
	yamlls = {
		on_attach = on_attach,
		settings = {
			yaml = {
				schemas = {
					kubernetes = "*.yaml", -- treat everything as k8s manifests and override for specific files below
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
					["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
					["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
					["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
					["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
					["https://json.schemastore.org/dependabot-2.0.json"] = ".github/dependabot.{yml,yaml}",
					["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
					["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
					["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
				},
			},
		},
	},

	-- JSON
	jsonls = {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		settings = {
			json = {
				schemas = {
					["https://docs.renovatebot.com/renovate-schema.json"] = "global-config.json5*",
				},
			},
		},
	},

	-- vue_ls = { on_attach = on_attach },
	-- ts_ls = { on_attach = on_attach },
	pylsp = { on_attach = on_attach },
	dockerls = { on_attach = on_attach },
	tailwindcss = { on_attach = on_attach },
	terraformls = {
		on_attach = on_attach,
		cmd = { "terraform-ls", "serve", "--log-file", "/tmp/terraform-lsp.log" },
		filetypes = { "terraform" },
	},
	tflint = { on_attach = on_attach },
	expert = {
		cmd = { "expert" },
		root_markers = { "mix.exs", ".git" },
		filetypes = { "elixir", "eelixir", "heex" },
	},
	gopls = {
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
	},
}

local function getTableKeys(tab)
	local keyset = {}
	for k, v in pairs(tab) do
		keyset[#keyset + 1] = k
	end
	return keyset
end

for key, config in pairs(lsp_configs) do
	vim.lsp.config(key, config)
end

vim.lsp.enable(getTableKeys(lsp_configs))

vim.diagnostic.config({ virtual_text = { current_line = true } })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.lsp.buf.format()
	end,
})
