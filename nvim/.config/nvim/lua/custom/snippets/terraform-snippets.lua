require("luasnip.session.snippet_collection").clear_snippets("terraform")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("terraform", {
	s(
		"name",
		fmt(
			[[
			variable "name" {{
				type = string
				description = "{}"
			}}
			]],
			{ i(0, "Name description") }
		)
	),
	s(
		"td",
		fmt(
			[[
#####
# {}
#####
			]],
			{ i(0, "Section description") }
		)
	),
})
