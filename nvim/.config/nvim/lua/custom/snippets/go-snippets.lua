require("luasnip.session.snippet_collection").clear_snippets("go")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("go", {
	s("ins", fmt('fmt.Printf("{} = %v\\n", {}{})', { i(1, "str"), rep(1, "replacement"), i(0) })),
	s({ trig = "iop", dscr = "print line" }, fmt('fmt.Println("{}")', { i(1) })),
})
