local opt = vim.opt
local o = vim.o
local g = vim.g
-------------------------------------- options ------------------------------------------
o.title = true
o.laststatus = 3
o.showmode = false
opt.termguicolors = true

o.clipboard = 'unnamedplus'
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.shiftround = true
o.linebreak = true
o.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true
o.splitkeep = "screen"

o.scrolloff = 8
o.history = 100
o.inccommand = 'split'

-- Folding
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Utilize Treesitter folds

-- Markdown
o.conceallevel = 2
o.concealcursor = "nc"

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, "/") .. ":" .. vim.env.PATH
