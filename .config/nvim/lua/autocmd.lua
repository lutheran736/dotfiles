local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name "NvFilePost"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "/tmp/calcurse*", "~/.calcurse/notes/*" },
  command = "set filetype=markdown"
})

-- Restore cursor position
autocmd({ "BufReadPost" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd('silent! normal! g`"zv', false)
  end,
})

-- Restore cursor position
autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd [[
    map <leader>c :w! \| !compiler "%:p"<CR>
    cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
    setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    ]]
  end,
})

autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    vim.cmd [[
      cnoreabbrev W! w!
      cnoreabbrev Q! q!
      cnoreabbrev Qall! qall!
      cnoreabbrev Wq wq
      cnoreabbrev Wa wa
      cnoreabbrev wQ wq
      cnoreabbrev WQ wq
      cnoreabbrev W w
      cnoreabbrev Q q
      cnoreabbrev Qall qall
  ]]
  end
})

autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[%s/\n\+\%$//e]])
  end,
})

autocmd({ "bufwritepre" }, {
  pattern = { "*.[ch]" },
  command = [[%s/\%$/\r/e]],
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Xresources,Xdefaults,xresources,xdefaults" },
  callback = function()
    vim.cmd("set filetype=xdefaults")
    vim.cmd("!xrdb %")
  end
})

autocmd({ "BufWritePost" }, {
  pattern = { "bm-files", "bm-dirs" },
  command = "!shortcuts",
})

autocmd({ "FileType" }, {
  pattern = { "css", "sh", "html" },
  command = "ColorizerAttachToBuffer",
})

autocmd({ "VimLeave" }, {
  pattern = { "*.tex" },
  command = "!texclear %"
})

autocmd({ "FileType" }, {
  pattern = { "markdown" },
  command = [[setlocal spell! spelllang=en]]
})

autocmd({ "FileType" }, {
  pattern = { "latex" },
  command = [[setlocal spell! spelllang=es]]
})

autocmd({ "BufWritePost" }, {
  pattern = { "*/dwmblocks/config.h*" },
  command = [[!cd ~/.local/src/dwmblocks; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks}]]
})

autocmd({ "BufWritePost" }, {
  pattern = { "*/dwm/config.h*" },
  command = [[!cd ~/.local/src/dwm; sudo make install]]
})

autocmd({ "FileType" }, {
  pattern = {
    "Jaq",
    "qf",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "lazy",
    "mason",
    "",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted
    ]]
  end,
})
