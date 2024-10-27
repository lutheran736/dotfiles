local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    c = { "clang-format" },
    bash = { "shfmt" },
    sh = { "shfmt" },
    zsh = { "beautysh" }
  },
}
return options
