local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("packer_bootstrap? " .. packer_bootstrap)
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function()
  -- Packer can manage itself
  use('wbthomason/packer.nvim')
  use({
        'junegunn/fzf',
        run = ':call fzf#install()'
  })

  use({
      'junegunn/fzf.vim',
      config = function()
          vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'
          vim.g.fzf_layout = {up ='~90%', window = { width = 0.8, height = 0.8, yoffset = 0.5, xoffset = 0.5, highlight = 'Todo', border = 'sharp' } }
      end
  })

  use({'lewis6991/gitsigns.nvim'})
  use('christoomey/vim-tmux-navigator')
  use('dyng/ctrlsf.vim')
  use('jremmen/vim-ripgrep')
  use('mbbill/undotree')
  use('editorconfig/editorconfig-vim')
  use({'jpalardy/vim-slime', branch = 'main'})

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  use('vimwiki/vimwiki')
  use('cespare/vim-toml')
  use('elixir-editors/vim-elixir')
  use('udalov/kotlin-vim')
  use('sheerun/vim-polyglot')

  -- use('szw/vim-maximizer')

  -- colorschemes
  use('gruvbox-community/gruvbox')
  use('NLKNguyen/papercolor-theme')
  use('flazz/vim-colorschemes')
  use('tjdevries/colorbuddy.vim')
  use('folke/tokyonight.nvim')

    -- Tim Pope
  use('tpope/vim-fugitive')
  use('tpope/vim-rhubarb')
  use('tpope/vim-surround')
  use('tpope/vim-repeat')
  use('tpope/vim-commentary')
  use('tpope/vim-unimpaired')


  use('nvim-lualine/lualine.nvim')
  use('kyazdani42/nvim-web-devicons')
  use('ThePrimeagen/harpoon')
  use('ThePrimeagen/git-worktree.nvim')
  use('ThePrimeagen/vim-be-good')

    -- ' Tree sitter
  use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  })

  use('nvim-treesitter/playground')

    -- ' LSP stuff
  use('neovim/nvim-lspconfig')
  use('nvim-lua/plenary.nvim')
  use('nvim-lua/popup.nvim')
  use('nvim-telescope/telescope.nvim')
  use('nvim-telescope/telescope-github.nvim')

  use({
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      branch = 'main'
  })

  use('nvim-telescope/telescope-live-grep-args.nvim')
  -- use('simrat39/symbols-outline.nvim')
  use('onsails/lspkind-nvim')
  use('j-hui/fidget.nvim')

-- ' Snippets
  use({
    'L3MON4D3/LuaSnip',
    config = function()
      vim.g.snippets = 'luasnip'
    end
  })
  use('saadparwaiz1/cmp_luasnip')
  use('rafamadriz/friendly-snippets')

-- ' completion
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-nvim-lua')
  use('hrsh7th/cmp-nvim-lsp')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
