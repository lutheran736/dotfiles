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
  group = num_au,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "/tmp/calcurse*", "~/.calcurse/notes/*" },
  command = "set filetype=markdown",
})

autocmd({ "BufWritePre", "BufNewFile" }, {
  pattern = { "*neomutt*" },
  command = [[%s/^--$/-- /e]],
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Xresources,Xdefaults,xresources,xdefaults" },
  command = "set filetype=xdefaults",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.css", "*.sh", "*.html" },
  command = "ColorizerAttachToBuffer",
})

autocmd({ "VimLeave" }, {
  pattern = { "*.tex" },
  command = "!texclear %"
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*md" },
  command = [[setlocal spell! spelllang=en]]
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tex" },
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
