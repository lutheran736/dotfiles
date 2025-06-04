local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<F5>", ":resize +2<CR>")
map("n", "<F6>", ":resize -2<CR>")
map("n", "<F7>", ":vertical resize +2<CR>")
map("n", "<F8>", ":vertical resize -2<CR>")

-- misc
map("n", "<leader>u", '<cmd>!linkhandler "<cWORD>" &<CR>', { silent = true }) --open a url under cursor
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })           --make a file executable
map("n", "<leader>t", "<cmd>!xdg-terminal-exec<CR>", { silent = true })    -- Terminal
map("n", "<leader>p", "<cmd>!opout '%:p'<CR>", { silent = true })          -- Open pdf
map("n", "<leader>c", "<cmd>!compiler '%:p'<CR>", { silent = true })          -- Open pdf
map("n", "S", [[:%s//g<Left><Left>]])                                      -- Replace word

-- format
map({ "n", "x" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- tab stuff
map("n", "<leader>to", "<cmd>tabnew<CR>")   --open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>") --close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>")     --go to next
map("n", "<leader>tp", "<cmd>tabp<CR>")     --go to pre
map("n", "<leader>tf", "<cmd>tabnew %<CR>") --open current tab in new tab

--split management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
map("n", "<leader>sl", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Gitsigns
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")
map("n", "<leader>gi", "<cmd>Gitsigns toggle_current_line_blame<cr>")

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- buffer
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close Buffer" })
map("n", "<leader>dq", "<cmd>bp|bd #<CR>", { desc = "Close Buffer; Retain Split" })
map("n", "<S-l>", "<cmd>bnext<CR>")
map("n", "<S-h>", "<cmd>bprevious<CR>")

-- Replace word under cursor across entire buffer
map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- ZenMode
map("n", "<leader>zm", "<cmd>ZenMode<cr>", { silent = true })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>fe", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>fn", "<cmd>Telescope nerdy<CR>", { desc = "telescope Preview glyphs" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })
map("n", "<leader>fs", "<cmd>Telescope spell_suggest<CR>", { desc = "Spell suggestions" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- Corrected minimal toggle for English/Spanish spell check
vim.keymap.set('n', '<leader>o', function()
  vim.wo.spell = true -- Enable spell for current window
  vim.bo.spelllang = vim.bo.spelllang == 'en_us' and 'es' or 'en_us'
  print("Spell language: " .. vim.bo.spelllang)
end, { desc = "Toggle spell language (en/es)" })

-- make
map("n", "<leader>ma", function() --quick make in dir of buffer
  local bufdir = vim.fn.expand("%:p:h")
  vim.cmd("lcd " .. bufdir)
  vim.cmd("!sudo make clean install %")
  vim.cmd("!sysact renew")
end, { desc = 'Compile current file suckless' })

-- web reader
map('n', 'gx', function ()
  vim.cmd('normal! "uyiW')
  local url = vim.fn.getreg('u')
  if url == '' then
    vim.notify('No URL found under cursor', vim.log.levels.WARN)
    return
  end
  vim.cmd('vsplit | terminal reader --image-mode sixel ' .. vim.fn.shellescape(url))
end)
