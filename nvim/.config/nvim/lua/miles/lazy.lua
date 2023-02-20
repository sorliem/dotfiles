local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			lazypath,
		})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
		{
			'junegunn/fzf',
			build = ':call fzf#install()'
		},
		{
			'junegunn/fzf.vim',
			init = function()
				vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'
				vim.g.fzf_layout = {
					up ='~90%',
					window = {
						width = 0.8,
						height = 0.8,
						yoffset = 0.5,
						xoffset = 0.5,
						highlight = 'Todo',
						border = 'sharp'
					}
				}
			end
		},
		'lewis6991/gitsigns.nvim',
		{'christoomey/vim-tmux-navigator', lazy = true},
		{'dyng/ctrlsf.vim', lazy = true},
		{'jremmen/vim-ripgrep', lazy = true},
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
		{
			'nvim-lualine/lualine.nvim',
			dependencies = {
				'kyazdani42/nvim-web-devicons',
			}
		},

		-- colorschemes
		'ellisonleao/gruvbox.nvim',
		{'fenetikm/falcon', lazy = true},
		{'NLKNguyen/papercolor-theme', lazy = true},
		{'ishan9299/nvim-solarized-lua', lazy = true},
		{'folke/tokyonight.nvim', lazy = true},

		-- Tim Pope
		'tpope/vim-fugitive',
		'tpope/vim-rhubarb',
		'tpope/vim-surround',
		'tpope/vim-repeat',
		'tpope/vim-commentary',
		'tpope/vim-unimpaired',

		'ThePrimeagen/harpoon',
		'ThePrimeagen/git-worktree.nvim',
		'ThePrimeagen/vim-be-good',

		-- Tree sitter
		{
			'nvim-treesitter/nvim-treesitter',
			build = ':TSUpdate',
			dependencies = {
				'nvim-treesitter/playground',
			}
		},

		-- ' LSP stuff
		'neovim/nvim-lspconfig',
		'nvim-lua/popup.nvim',
		{
			'j-hui/fidget.nvim',
			lazy = true
		},

		-- Telecope
		{
			'nvim-telescope/telescope.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-telescope/telescope-live-grep-args.nvim',
				{
					'nvim-telescope/telescope-fzf-native.nvim',
					build = 'make',
					branch = 'main',
					dependencies = {
						'nvim-telescope/telescope.nvim',
					}
				},
			}
		},

		-- Snippets
		{
			'L3MON4D3/LuaSnip',
			config = function()
				vim.g.snippets = 'luasnip'
			end,
			dependencies = {
				'saadparwaiz1/cmp_luasnip',
				'rafamadriz/friendly-snippets',
			}
		},

		-- completion
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/cmp-nvim-lsp',
		'onsails/lspkind-nvim'
	})
