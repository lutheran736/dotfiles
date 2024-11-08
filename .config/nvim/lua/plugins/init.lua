return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    config = function()
      require("config.lualine")
    end,
  },

  {
    'folke/zen-mode.nvim',
    cmd  = "ZenMode",
    opts = function()
      return require "config.zenmode"
    end,
  },

  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "|" },
      scope = { char = "|" },
    },
    config = function(_, opts)
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "config.nvimtree"
    end,
  },
  -- formatting!
  {
    "stevearc/conform.nvim",
    opts = require "config.conform",
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    opts = function()
      return require "config.gitsigns"
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = "Git"
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "config.mason"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require("config.lspconfig").defaults()
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "config.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "config.cmp"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "config.telescope"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "config.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "vimwiki/vimwiki",
    ft = "markdown",
    cmd = { "VimwikiIndex" },
    keys = { "<leader>ww", "<leader>wt" },
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/docs/vimwiki",
          syntax = "markdown",
          ext = "md",
        },
      }
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDettachFromBuffer", "ColorizerRelaodAllBuffer" },
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
  },

  {
    "hiphish/rainbow-delimiters.nvim",
    event = "User FilePost"
  },

}
