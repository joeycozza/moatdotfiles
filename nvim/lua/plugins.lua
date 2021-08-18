-- ****************************
-- Bootstrapping Packer
-- ****************************
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end


-- ****************************
-- Plugins
-- ****************************
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Simple plugins can be specified as strings
  use '9mm/vim-closer'
  use 'junegunn/limelight.vim'
  use 'ryanoasis/vim-devicons'
  use 'kyazdani42/nvim-web-devicons'
  use 'folke/lsp-colors.nvim'
  use 'shaunsingh/nord.nvim'
  use 'shaunsingh/seoul256.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'ap/vim-css-color'
  use "rcarriga/nvim-notify"
  
  --Navigation
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
  'nvim-telescope/telescope.nvim',
  config = function()
    require('configs.telescope')
  end
  }
  
  --Father Pope
  use 'tpope/vim-abolish'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-dadbod'
  
  use 'kristijanhusak/vim-dadbod-ui'
  
  --Undo
  use 'mbbill/undotree'
  use 'simnalamburt/vim-mundo'
  
  --Git
  use { 
    'TimUntersberger/neogit', {
      requires = 'nvim-lua/plenary.nvim',
      config = require('configs.neogit')
    }
  }
  use {
  'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require('gitsigns').setup() end
  }
  use 'tpope/vim-fugitive'
  
  --Utilities
  use 'vimwiki/vimwiki'
  use 'scrooloose/nerdcommenter'
  use 'scrooloose/nerdtree'
  use 'jiangmiao/auto-pairs'
  use 'junegunn/vim-easy-align'
  use 'SirVer/ultisnips'
  use {
    'folke/which-key.nvim',
    config = function()
      require('configs.which-key')
    end
  }
  use 'folke/trouble.nvim'
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('todo-comments').setup() end
  }
  use 'svermeulen/vimpeccable'
  use {'kristijanhusak/orgmode.nvim', config = function()
          require('orgmode').setup{}
    end
  }
  use {
    'hoob3rt/lualine.nvim',
    config = function() 
      require('configs.lualine')
    end
  }

  
  --Javascript/Node
  use 'pangloss/vim-javascript'
  use 'mxw/vim-jsx'
  use 'othree/yajs.vim'
  use 'othree/javascript-libraries-syntax.vim'
  use 'leafgarland/typescript-vim'
  
  --Other Language Stuff
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use {
    'hrsh7th/nvim-compe',
    config = function() 
      require('configs.compe')
    end
  }
  use 'dense-analysis/ale'
  use {
    'fatih/vim-go',
    ft = 'go'
  }
  use 'rust-lang/rust.vim'
  use {
    'numtostr/FTerm.nvim',
    config = function()
      require('configs.floatterm')
    end
  }
  use {
    'mfussenegger/nvim-dap',
    config = function() 
      require('configs.dap')
    end
  }
  use 'Pocco81/DAPInstall.nvim'
end)

