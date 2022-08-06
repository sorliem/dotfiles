return require("packer").startup(function()
  use("junegunn/fzf"), { 'do': { -> fzf#install() } }
  use("junegunn/fzf.vim")
  -- let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
  -- let $FZF_DEFAULT_COMMAND="rg --files --hidden --color=ansi"

  use("christoomey/vim-tmux-navigator")
  use("sheerun/vim-polyglot")
  use("junegunn/vim-peekaboo")
  use("junegunn/goyo.vim")
  use("elixir-editors/vim-elixir")
  use("jremmen/vim-ripgrep")
  use("mbbill/undotree")
  use("gruvbox-community/gruvbox")

  use("scrooloose/nerdtree")
  -- let NERDTreeShowHidden=1
  -- let g:NERDTreeHijackNetrw=0

  use("airblade/vim-gitgutter")
  use("editorconfig/editorconfig-vim")
  -- let g:EditorConfig_exclude_patterns = ['fugitive://.*']

  use("jpalardy/vim-slime"), { 'branch': 'main' }
  -- if exists('$TMUX')
  --     let g:slime_target = "tmux"
  --     let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": "3"}
  --     let g:slime_dont_ask_default = 1
  -- endif

  use("vimwiki/vimwiki")

  use("dyng/ctrlsf.vim")
  use("cespare/vim-toml")
  use("udalov/kotlin-vim")
  use("szw/vim-maximizer")
  use("NLKNguyen/papercolor-theme")
  use("flazz/vim-colorschemes")
  use("tjdevries/colorbuddy.vim")
  use("folke/tokyonight.nvim")

    -- " Tim Pope
  use("tpope/vim-fugitive")
  use("tpope/vim-rhubarb")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("tpope/vim-commentary")
  use("tpope/vim-unimpaired")


  use("nvim-lualine/lualine.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("ThePrimeagen/harpoon")
  use("ThePrimeagen/git-worktree.nvim")

" Tree sitter
  use("nvim-treesitter/nvim-treesitter"), {'do': ':TSUpdate'}
  use("nvim-treesitter/playground")

" LSP stuff
  use("neovim/nvim-lspconfig")
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-fzf-native.nvim"), { 'do': 'make', 'branch': 'main' }
  use("nvim-telescope/telescope-live-grep-args.nvim")
  -- use("simrat39/symbols-outline.nvim")
  use("onsails/lspkind-nvim")
  use("j-hui/fidget.nvim")

-- " Snippets
  use("L3MON4D3/LuaSnip")
  -- let g:snippets = "luasnip"
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

-- " completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-nvim-lsp")
end)