local lualine = require("lualine")
lualine.setup({
  options = {
    theme = "auto",
    component_separators = "|",
    section_separators = { left = "", right = "" },
    icons_enabled = true
  },
  sections = {
    lualine_a = {
      { 'mode', fmt = function(str) return ' ' .. str:sub(1, 1) end }
    },
    lualine_b = {
      { 'branch', icon = '' }
    },
    lualine_c = {
      { 'filename', path = 0 },
      { 'diff',     symbols = { added = '+', modified = '~', removed = '-' } }
    },
    lualine_x = {
      'filetype'
    }
  },
})
