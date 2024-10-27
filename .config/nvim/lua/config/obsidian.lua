local options = {

  workspaces = {
    {
      name = "personal",
      path = "~/docs/obsidian/personal",
    },
    {
      name = "work",
      path = "~/docs/obsidian/work",
    },
  },

  completion = {
    nvim_cmp = true,
    min_chars = 1,
  },

}

return options
