return {
	"tpope/vim-sleuth",
	{ "tpope/vim-surround",   event = { "BufRead" } },
	{ "tpope/vim-repeat",     event = { "BufRead" } },
	{ "tpope/vim-commentary", cond = false },
	{ "tpope/vim-unimpaired" },
	{
		"tpope/vim-abolish",
		config = function()
			vim.cmd([[
					Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
					Abolish teh the
					Abolish fiel file
					Abolish taht that
					Abolish persistent persistant
					Abolish functoin function
					Abolish fucnton function
					Abolish fucntion function
					Abolish fuction function
					Abolish funciton function

					Abolish {is,was,do,does,did,would,could,should,wo,ca}nt {}n't
					Abolish {he,here,she,that,there,where}s {}'s
					Abolish {I,we,you,they}ve {}'ve
					Abolish {is,was,do,does,did,would,could,should,wo,ca}nt {}n't
					Abolish {you,they}re {}'re
					

					Abolish varible variable
			]])
		end,
	},
}
