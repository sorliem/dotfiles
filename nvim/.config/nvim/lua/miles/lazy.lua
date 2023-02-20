-- local fn = vim.fn
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--   print("packer_bootstrap? " .. packer_bootstrap)
--   vim.cmd [[packadd packer.nvim]]
-- end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({
  {
        'junegunn/fzf',
        build = ':call fzf#install()'
  },
  {
      'junegunn/fzf.vim',
      config = function()
          vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'
          vim.g.fzf_layout = {up ='~90%', window = { width = 0.8, height = 0.8, yoffset = 0.5, xoffset = 0.5, highlight = 'Todo', border = 'sharp' } }
      end
  },

  'lewis6991/gitsigns.nvim',
  'christoomey/vim-tmux-navigator',
  'dyng/ctrlsf.vim',
  'jremmen/vim-ripgrep',
  'mbbill/undotree',
  'editorconfig/editorconfig-vim',
  {'jpalardy/vim-slime', branch = 'main'},

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  'vimwiki/vimwiki',
  'cespare/vim-toml',
  'elixir-editors/vim-elixir',
  'udalov/kotlin-vim',
  'sheerun/vim-polyglot',
  'nvim-lualine/lualine.nvim',
  'kyazdani42/nvim-web-devicons',

  -- colorschemes
  'ellisonleao/gruvbox.nvim',
  'fenetikm/falcon',
  'NLKNguyen/papercolor-theme',
  'flazz/vim-colorschemes',
  'tjdevries/colorbuddy.vim',
  'folke/tokyonight.nvim',
  'ishan9299/nvim-solarized-lua',

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
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  'nvim-treesitter/playground',

  -- ' LSP stuff
  'neovim/nvim-lspconfig',
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'onsails/lspkind-nvim',
  'j-hui/fidget.nvim',

  -- Telecope
  'nvim-telescope/telescope.nvim',
  'nvim-telescope/telescope-github.nvim',
  {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      branch = 'main'
  },
  'nvim-telescope/telescope-live-grep-args.nvim',

  -- Snippets
  {
    'L3MON4D3/LuaSnip',
    config = function()
      vim.g.snippets = 'luasnip'
    end
  },
  'saadparwaiz1/cmp_luasnip',
  'rafamadriz/friendly-snippets',

  -- completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp',

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  -- if packer_bootstrap then
  --   require('packer').sync()
  -- end
})
