local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    bash = { "shfmt" },
    sh = { "shfmt" },
    markdown = { "prettier" },
    yaml = { "prettier" },
    yml = { "prettier" }
  },
}
return options
