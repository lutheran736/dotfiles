-- Setup Custom wiki path if required
require('kiwi').setup({
    {
        name = "work",
        path = "work-wiki"
    },
    {
        name = "personal",
        path = "personal-wiki"
    }
})
-- Note: The path will be created in user home directory

-- Use default path (i.e. ~/wiki/)
local kiwi = require('kiwi')

-- Necessary keybindings
vim.keymap.set('n', '<leader>ww', kiwi.open_wiki_index, {})
vim.keymap.set('n', 'T', kiwi.todo.toggle, {})
