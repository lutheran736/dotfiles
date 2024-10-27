-- load defaults i.e lua_lsp
require("config.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "clangd", "bashls", "texlab"}
local nvlsp = require "config.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
