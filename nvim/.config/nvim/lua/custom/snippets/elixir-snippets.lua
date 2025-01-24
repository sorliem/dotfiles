require("luasnip.session.snippet_collection").clear_snippets("elixir")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("elixir", {
	s({ trig = "ins", dscr = "inspect term" }, fmt('IO.inspect({}, label: "{}{}")', { i(1, "var"), rep(1), i(0) })),
	s({ trig = "pins", dscr = "pipe into inspect" }, fmt('|> IO.inspect(label: "{}")', { i(1, "label") })),
	s({ trig = "iop", dscr = "io puts" }, fmt('IO.puts("{}")', { i(1) })),
	s({ trig = "mdoc", dscr = "create moduledoc" }, fmt('@moduledoc """\n{}\n"""', { i(1) })),
	s({ trig = "fdoc", dscr = "create function doc" }, fmt('@doc """\n{}\n"""', { i(1) })),
	s({ trig = "test", dscr = "create simple test" }, fmt('test "{}" do \n{}\nend', { i(1, "test_name"), i(2) })),
	s({ trig = "exu", dscr = "import ExUnit.Case" }, t("use ExUnit.Case")),
	s({ trig = "itest", dscr = "create simple exunit test" }, fmt('it "{}" do \n{}\nend', { i(1, "test_name"), i(2) })),
	s({ trig = "assert", dscr = "assert var" }, fmt("assert {} == {}", { i(1, "left"), i(2, "right") })),
	s({ trig = "assert_recv", dscr = "assert receive" }, fmt("assert_receive {}", { i(1) })),
	s(
		{ trig = "mod", dscr = "Define an elixir module" },
		fmt(
			[[
						defmodule {} do
						  @moduledoc """
						  """

						  {}
						end
						]],
			{ i(1, "mod_name"), i(0) }
		)
	),
	s(
		{ trig = "def", dscr = "Define an elixir functio" },
		fmt(
			[[
						def {}({}) do
						  {}
						end
						]],
			{ i(1, "func_name"), i(2, "arg"), i(0) }
		)
	),
	s(
		{ trig = "tmodeu", dscr = "Define a test module with ExUnit.Case loaded" },
		fmt(
			[[
						defmodule {}Test do
							use ExUnit.Case

							setup do

							end

							test "{}" do
							end
						end
						]],
			{ i(1, "mod_under_test"), i(0, "first_test_name") }
		)
	),
	s(
		{ trig = "tmodes", dscr = "Define a test module with ExSpec loaded" },
		fmt(
			[[
						defmodule {}Test do
								use ExSpec

								setup do

								end

								it "should {}" do
										{}
								end
						end
						]],
			{ i(1, "mod_under_test"), i(2, "first_test_name"), i(0) }
		)
	),
	s("cap", t("import ExUnit.CaptureLog")),
	s(
		"acap",
		fmt(
			[[
						assert capture_log(fn ->
						  {}
						end) =~ "{}"
						]],
			{ i(1, "assertion"), i(0, "log contents") }
		)
	),
})
