return {
		{
			'dstein64/vim-startuptime',
			cmd = 'StartupTime'
		},
		'dyng/ctrlsf.vim',
		{'christoomey/vim-tmux-navigator', lazy = true},
		{'mbbill/undotree', lazy = true},
		{'editorconfig/editorconfig-vim', lazy = true},
		{'jpalardy/vim-slime', branch = 'main'},
		{
			'iamcco/markdown-preview.nvim',
			build = 'cd app && npm install',
			init = function()
				vim.g.mkdp_filetypes = { 'markdown' }
			end,
			ft = { 'markdown' },
		},
		{'vimwiki/vimwiki', lazy = true},
		{'cespare/vim-toml', ft = 'toml'},
		{'elixir-editors/vim-elixir', ft = { 'elixir', 'eelixir' }},
		{'udalov/kotlin-vim', ft = 'kotlin'},

		-- Tim Pope
		'tpope/vim-fugitive',
		'tpope/vim-rhubarb',
		'tpope/vim-surround',
		'tpope/vim-repeat',
		'tpope/vim-commentary',
		'tpope/vim-unimpaired',

		'ThePrimeagen/vim-be-good',

		{
			'nvim-lua/popup.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim'
			},
		}
	}
