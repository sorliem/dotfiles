return {
	"tpope/vim-sleuth",
	{ "tpope/vim-surround", event = { "BufRead" } },
	{ "tpope/vim-repeat", event = { "BufRead" } },
	{ "tpope/vim-commentary", cond = false },
	{ "tpope/vim-unimpaired", event = { "InsertEnter" } },
	{
		"tpope/vim-abolish",
		config = function()
			vim.cmd([[
					Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
					Abolish functoin function
					Abolish fucnton function
					Abolish fucntion function
					Abolish fuction function
			]])
		end,
	},
}
