require("luasnip.session.snippet_collection").clear_snippets("vue")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("vue", {
	s("ins", fmt("console.log('{} = ' + {}{})", { i(1, "label"), rep(1), i(0) })),
})
