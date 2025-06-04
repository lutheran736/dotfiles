local options = {
  window = {
    backdrop = 0.95,        -- Slightly dimmed backdrop
    width = 100,            -- Fixed width (cells)
    height = 1,             -- Full editor height
    options = {
      signcolumn = "no",    -- Hide signs (Git/diagnostics)
      number = false,       -- No line numbers
      relativenumber = false,
      cursorline = false,   -- Disable highlight
      list = false,         -- Hide whitespace chars
      foldcolumn = "0",     -- disable fold column
      cursorcolumn = false, -- disable cursor column
    },
  },
  plugins = {
    options = {
      ruler = false,                -- Disable cmdline ruler
      showcmd = false,              -- Hide typed commands
      laststatus = 0,               -- No statusline
    },
    gitsigns = { enabled = false }, -- Disable Git clutter
    twilight = { enabled = false }, -- No Twilight integration
  },
}

return options
