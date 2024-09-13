return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		event = { "InsertEnter" },
		config = function()
			vim.g.snippets = "luasnip"

			if vim.g.snippets ~= "luasnip" then
				return
			end

			local ls = require("luasnip")
			local s = ls.snippet
			local snippet_from_nodes = ls.sn
			local i = ls.insert_node
			local t = ls.text_node
			local d = ls.dynamic_node
			local c = ls.choice_node
			local fmt = require("luasnip.extras.fmt").fmt
			local rep = require("luasnip.extras").rep
			local types = require("luasnip.util.types")

			local require_var = function(args, _)
				local text = args[1][1] or ""
				local split = vim.split(text, ".", { plain = true })

				local options = {}
				for len = 0, #split - 1 do
					table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
				end

				return snippet_from_nodes(nil, {
					c(1, options),
				})
			end

			ls.config.set_config({
				history = false,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { " « CHOICE " } },
							hl_group = "GruvboxBlue",
						},
						unvisited = {
							hl_group = "GruvboxGreen",
						},
					},
				},
			})

			local all_snippets = {}

			local javascript_snippets = {
				s("ins", fmt("console.log('{} = ' + {}{})", { i(1, "label"), rep(1), i(0) })),
			}

			local lua_snippets = {
				s({ trig = "for", dscr = "for loop in lua" }, {
					t("for "),
					i(1, "k, v"),
					t(" in "),
					i(2, "ipairs()"),
					t({ " do", "  " }),
					i(0),
					t({ "", "" }),
					t("end"),
				}),
				s(
					"req",
					fmt([[local {} = require("{}")]], {
						d(2, require_var, { 1 }),
						i(1),
					})
				),
				s(
					{ trig = "ins", desc = "inspect vim object in lua" },
					fmt([[print("{} = " .. vim.inspect({}{}))]], {
						i(1, "label"),
						rep(1),
						i(0),
					})
				),
				s(
					{ trig = "insx", desc = "inspect vim object in lua" },
					fmt([[ngx.log(ngx.INFO, "{} = ", {}{})]], {
						i(1, "label"),
						rep(1),
						i(0),
					})
				),
			}

			local elixir_snippets = {
				s(
					{ trig = "ins", dscr = "inspect term" },
					fmt('IO.inspect({}, label: "{}{}")', { i(1, "var"), rep(1), i(0) })
				),
				s({ trig = "pins", dscr = "pipe into inspect" }, fmt('|> IO.inspect(label: "{}")', { i(1, "label") })),
				s({ trig = "iop", dscr = "io puts" }, fmt('IO.puts("{}")', { i(1) })),
				s({ trig = "mdoc", dscr = "create moduledoc" }, fmt('@moduledoc """\n{}\n"""', { i(1) })),
				s({ trig = "fdoc", dscr = "create function doc" }, fmt('@doc """\n{}\n"""', { i(1) })),
				s(
					{ trig = "test", dscr = "create simple test" },
					fmt('test "{}" do \n{}\nend', { i(1, "test_name"), i(2) })
				),
				s({ trig = "exu", dscr = "import ExUnit.Case" }, t("use ExUnit.Case")),
				s(
					{ trig = "itest", dscr = "create simple exunit test" },
					fmt('it "{}" do \n{}\nend', { i(1, "test_name"), i(2) })
				),
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
			}

			local go_snippets = {
				s("ins", fmt('fmt.Printf("{} = %v\\n", {}{})', { i(1, "str"), rep(1, "replacement"), i(0) })),
				s({ trig = "iop", dscr = "print line" }, fmt('fmt.Println("{}")', { i(1) })),
			}

			local python_snippets = {
				s("ins", fmt('print("{} = {{0}}".format({}{}))', { i(1, "str"), rep(1, "replacement"), i(0) })),
			}

			ls.add_snippets("all", all_snippets)
			ls.add_snippets("lua", lua_snippets)
			ls.add_snippets("elixir", elixir_snippets)
			ls.add_snippets("go", go_snippets)
			ls.add_snippets("javascript", javascript_snippets)
			ls.add_snippets("vue", javascript_snippets)
			ls.add_snippets("python", python_snippets)

			-- <c-k> is my expansion key
			-- this will expand the current item or jump to the next item within the snippet.
			vim.keymap.set({ "i", "s" }, "<c-k>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			-- <c-j> is my jump backwards key
			-- this always moves to the previous item within the snippet
			vim.keymap.set({ "i", "s" }, "<c-j>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			-- <c-l> is selecting within a list of options.
			-- This is useful for choice nodes
			vim.keymap.set("i", "<c-j>", function()
				if ls.choice_active() then
					ls.change_choice()
				end
			end)

			-- require("luasnip.loaders.from_vscode").lazy_load()

			-- add html snips to elixir templates
			require("luasnip").filetype_extend("eelixir", { "html" })
			require("luasnip").filetype_extend("nginx", { "lua" })

			-- add terraform snippets
			-- require("luasnip").filetype_extend("terraform", { "terraform" })

			vim.cmd.source("~/.config/nvim/after/plugin/terraform-snippets.lua")

			local source_external_snippets = function()
				vim.cmd.source("~/.config/nvim/lua/plugins/snippets.lua")
				vim.cmd.source("~/.config/nvim/after/plugin/work-snippets.lua")
			end

			vim.keymap.set("n", "<Leader>rs", function()
				ls.cleanup()
				source_external_snippets()
				print("dumped and reloaded snippets")
			end, { desc = "[R]eload [S]nippets", noremap = true, silent = true })

			-- set keybinds for both INSERT and VISUAL.
			vim.keymap.set("i", "<C-n>", "<Plug>luasnip-next-choice")
			vim.keymap.set("s", "<C-n>", "<Plug>luasnip-next-choice")
			vim.keymap.set("i", "<C-p>", "<Plug>luasnip-prev-choice")
			vim.keymap.set("s", "<C-p>", "<Plug>luasnip-prev-choice")

			source_external_snippets()
		end,
	},
}
