vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "config.lazy"

require("lazy").setup({
    {
      'navarasu/onedark.nvim',
      lazy = false,
     config = function()
      vim.cmd("colorscheme onedark")
    end,
    },
    { import = "plugins" },
},lazy_config)

require "options"
require "autocmd"
require("config.lsp-server")

--require "config.lazy"
vim.schedule(function()
require "mappings"
end)
