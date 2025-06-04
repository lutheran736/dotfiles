local autocmd = vim.api.nvim_create_autocmd

-- File loading events
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
      vim.api.nvim_del_augroup_by_name("NvFilePost")

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})
        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- UI Enhancements
autocmd("TextYankPost", {
  pattern = "*",
  callback = function() vim.hl.on_yank({ timeout = 300 }) end, -- Highlight yanked text
})

autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
            not (ft:match('commit') and ft:match('rebase'))
            and last_known_line > 1
            and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- Filetype detection
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "/tmp/calcurse*", "~/.calcurse/notes/*" },
  command = "setf markdown", -- Treat calcurse notes as markdown
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Xresources", "Xdefaults" },
  command = "setf xdefaults", -- Correct syntax for X configs
})

autocmd("BufWritePost", {
  pattern = { "Xresources", "Xdefaults" },
  callback = function() vim.fn.system("!xrdb %") end, -- Reload Xresources on save
})

autocmd("BufWritePost", {
  pattern = { "bm-files", "bm-dirs" },
  callback = function() vim.fn.system("!shortcuts") end, -- Reload Xresources on save
})

-- Buffer management
autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup", "checkhealth", "help", "lspinfo", "qf",
    "startuptime", "man", "Jaq", "notify", "spectre_panel", "Lazy", "Mason"
  },
  callback = function(event) -- Close special buffers with 'q'
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Formatting
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Save cursor position
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- Clean trailing whitespace
    vim.cmd("%s/\\s\\+$//e")
    -- Remove multiple EOF newlines
    vim.cmd("%s/\\n\\+\\%$//e")
    -- Ensure trailing newline for C files
    if vim.fn.expand("%:e") == "c" or vim.fn.expand("%:e") == "h" then
      vim.cmd("%s/\\%$/\\r/e")
    end
    -- Fix neomutt email signatures
    if vim.fn.expand("%:p"):match("neomutt") then
      vim.cmd("%s/^--$/-- /e")
    end
    -- Restore cursor position
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end
})

-- Filetype behaviors
autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "text", "markdown", "gitcommit" },
  callback = function() -- Enable wrap and spell for text files
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt.spelllang = { "es", "en" }
  end,
})

autocmd("FileType", {
  pattern = "*",
  callback = function() -- Disable auto-comments
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Utilities
autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event) -- CreatGGe missing directories
    if not event.match:match("^%w%w+:[\\/][\\/]") then
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
  end,
})

autocmd("FileType", {
  pattern = { "css", "html", "sh" },
  callback = function() vim.cmd.ColorizerAttachToBuffer() end, -- Enable colorizer
})

autocmd("BufWritePost", {
  pattern = os.getenv("HOME") .. "/docs/*",
  callback = function()
    vim.fn.system("git-sync")
  end,
})

-- suckless program
autocmd("BufWritePost", {
  pattern = os.getenv("HOME") .. "/.local/src/dwmblocks/config.h",
  callback = function()
    vim.fn.system("cd ~/.local/src/dwmblocks/ && sudo make clean install && killall -q dwmblocks && setsid -f dwmblocks")
  end,
})

autocmd("BufWritePost", {
  pattern = os.getenv("HOME") .. "/.local/src/st/config.h",
  callback = function()
    vim.fn.system("cd ~/.local/src/st/ && sudo make clean install")
  end,
})

autocmd("BufWritePost", {
  pattern = os.getenv("HOME") .. "/.local/src/dwm/config.h",
  callback = function()
    vim.fn.system("cd ~/.local/src/dwm/ && sudo make clean install && sysact renew")
  end,
})
