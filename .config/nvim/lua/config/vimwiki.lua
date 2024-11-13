vim.g.vimwiki_list = {
  {
    path = '~/docs/vimwiki',
    syntax = 'markdown',
    ext = '.md',
    diary_rel_path = 'Notes'
  },
}
vim.g.vimwiki_ext2syntax = {
  ['.Rmd'] = 'markdown',
  ['.rmd'] = 'markdown',
  ['.md'] = 'markdown',
  ['.markdown'] = 'markdown',
  ['.mdown'] = 'markdown'
}

vim.g.vimwiki_syntax_plugins = {
  codeblock = {
    ["```lua"] = { parser = "lua" },
    ["```python"] = { parser = "python" },
    ["```javascript"] = { parser = "javascript" },
    ["```bash"] = { parser = "bash" },
    ["```html"] = { parser = "html" },
    ["```css"] = { parser = "css" },
    ["```c"] = { parser = "c" },
  },
}
vim.g.vimwiki_auto_header = 1
vim.g.vimwiki_links_space_char = '_'
vim.g.vimwiki_listsyms = '✗○◐●✓'
vim.g.vimwiki_global_ext = 0        -- don't treat all md files as vimwiki (0)
vim.g.vimwiki_folding = "list"
vim.g.vimwiki_hl_headers = 1        -- use alternating colours for different heading levels
vim.g.vimwiki_markdown_link_ext = 1 -- add markdown file extension when generating links
vim.g.taskwiki_markdown_syntax = "markdown"
vim.g.indentLine_conceallevel = 2   -- indentline controlls concel
--vim.set.o.conceallevel = 1 -- so that I can see `` and full urls in markdown files

vim.api.nvim_set_keymap("n", "<F3>", ":VimwikiDiaryPrevDay<CR>", { noremap = true, silent = true, nowait = true })
vim.api.nvim_set_keymap("n", "<F4>", ":VimwikiDiaryNextDay<CR>", { noremap = true, silent = true, nowait = true })

vim.api.nvim_create_autocmd({'BufNewFile'}, {
    pattern = { "*Notes/*.md" },
    command = [[0r! ~/docs/vimwiki/Template/vimwiki-diary-tpl.py '%']],
})

vim.cmd [[
function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>
]]
