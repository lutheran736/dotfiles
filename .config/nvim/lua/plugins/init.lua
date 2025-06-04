return {

  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    config = function()
      local neopywal = require("neopywal")
      neopywal.setup({
        transparent_background = true,
      })
      vim.cmd.colorscheme("neopywal")
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
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
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = function()
      require "config.conform"
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    cmd = "Gitsigns",
    opts = function()
      return require "config.gitsigns"
    end,
  },

  -- lsp stuff
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    build = ":MasonUpdate",
    opts = function()
      return require "config.mason"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "User FilePost" },
    config = function()
      require("config.lspconfig")
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
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "2kabhishek/nerdy.nvim" },
    },
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
    'serenevoid/kiwi.nvim',
    opts = {
      {
        name = "personal",
        path = "docs/personal"
      },
    },
    keys = {
      { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
      { "T",          ":lua require(\"kiwi\").todo.toggle()<cr>",     desc = "Toggle Markdown Task" }
    },
  },

  {
    'norcalli/nvim-colorizer.lua',
    cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDettachFromBuffer", "ColorizerRelaodAllBuffer" },
  },

  {
    "hiphish/rainbow-delimiters.nvim",
    event = "User FilePost"
  },

  {
    "kylechui/nvim-surround",
    event = "User FilePost",
    config = function()
      require("nvim-surround").setup()
    end
  },

  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "codecompanion" },
    opts = {
      preview = {
        filetypes = { "md", "markdown", "codecompanion" },
      },
    },
  },

}
