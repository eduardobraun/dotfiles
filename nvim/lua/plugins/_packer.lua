vim.cmd [[packadd packer.nvim]]

local packer = require('packer')

return packer.startup(function()
  local use = packer.use
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Visuals
  use {
        'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end,
  }
  use 'lifepillar/vim-gruvbox8'
  use 'npxbr/gruvbox.nvim'
  use 'rktjmp/lush.nvim'
  use 'EdenEast/nightfox.nvim' -- trying new theme
  use 'machakann/vim-highlightedyank'
  use 'ryanoasis/vim-devicons'
  use {
    'hoob3rt/lualine.nvim',
    requires = {
        {'kyazdani42/nvim-web-devicons', opt = true},
    },
    config = function() require('plugins._lualine') end,
  }
  -- Markup/Text
  use {'cespare/vim-toml', branch = 'main'}
  use 'lervag/vimtex'
  -- LSP
  use 'neovim/nvim-lspconfig'
  -- use 'nvim-lua/lsp_extensions.nvim' -- Temp, VirtualText types
  use 'nvim-lua/lsp-status.nvim' -- Messages @ statusbar
  use {
    'ray-x/lsp_signature.nvim', -- function signature popup
    config = function() require('plugins._lsp_signature') end,
  }
  -- Language Specific
  use 'simrat39/rust-tools.nvim'
  use 'DingDean/wgsl.vim' -- wgsl syntax
  use 'fatih/vim-go'
  use 'liuchengxu/graphviz.vim'
  use "jose-elias-alvarez/null-ls.nvim"
  use "jose-elias-alvarez/nvim-lsp-ts-utils"
  -- Git/VC/CICD
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  -- Completion/Snips
  use {
    "hrsh7th/nvim-compe",
    opt = false,
    config = function() require("plugins._compe") end,
    requires = {
      {
        "L3MON4D3/LuaSnip",
        config = function() require("plugins._snippets") end,
      },
    },
  }
  -- Search/FZF
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = function() require('plugins._telescope') end,
  }
  -- Etc
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-commentary'
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        { "nvim-treesitter/playground" },
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
      },
      config = function() require('plugins._treesitter') end,
  }
  use {
    "folke/which-key.nvim",
    config = function() require("plugins._whichkey") end,
  }
end)
