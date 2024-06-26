return {
	"nvim-neorg/neorg",
	-- build = ":Neorg sync-parsers",
	-- ft = { "norg" },
	cond = false,
	keys = {
		{ "<Leader>no", ":Neorg workspace work<CR>" },
	},
	opts = {
		load = {
			["core.defaults"] = {},       -- Loads default behaviour
			["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
			["core.norg.dirman"] = {      -- Manages Neorg workspaces
				config = {
					workspaces = {
						work = "~/notes/work",
						personal = "~/notes/personal",
					},
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
