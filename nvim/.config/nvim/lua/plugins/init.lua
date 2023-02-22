-- see other files in this dir for plugin setups with larger configs
return {
		{'mbbill/undotree', lazy = true},
		{'christoomey/vim-tmux-navigator', lazy = true},
		'dyng/ctrlsf.vim',
		{'dstein64/vim-startuptime', cmd = 'StartupTime'},
		{'editorconfig/editorconfig-vim', lazy = true},
		{'vimwiki/vimwiki'},
		{'cespare/vim-toml', ft = 'toml'},
		{'elixir-editors/vim-elixir', ft = { 'elixir', 'eelixir' }},
		{'udalov/kotlin-vim', ft = 'kotlin'},
		{'jparise/vim-graphql', ft = 'graphql'},

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
