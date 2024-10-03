require("luasnip.session.snippet_collection").clear_snippets("python")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("python", {
	s("ins", fmt('print("{} = {{}}".format({})){}', { i(1, "str"), rep(1, "replacement"), i(0) })),
})
