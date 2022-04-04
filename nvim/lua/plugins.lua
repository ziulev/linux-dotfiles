local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'projekt0n/github-nvim-theme' -- Theme
  use 'nvim-treesitter/nvim-treesitter' -- Treesitter

  -- cmp
  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    -- snippets
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  }

  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = 'nvim-lua/plenary.nvim',
  }
end)
