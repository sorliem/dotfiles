if vim.g.snippets ~= "luasnip" then
	return
end

local ls = require("luasnip")
local snippet = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local multi_snippet = ls.multi_snippet
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local helpers = require("miles.luasnip_helpers")
local postfix = require("luasnip.extras.postfix").postfix

local terraform_snippets = {
	snippet(
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
}

ls.add_snippets("terraform", terraform_snippets)
