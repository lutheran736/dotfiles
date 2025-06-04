local map = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local function opts(desc)
      return { buffer = event.buf, desc = "LSP " .. desc }
    end

    -- Navigation mappings
    map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
    map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
    map("n", "gr", vim.lsp.buf.references, opts("Show references"))
    map("n", "gT", vim.lsp.buf.type_definition, opts("Go to type definition"))

    -- Code actions and refactoring
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
    map("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Signature help"))

    -- Workspace management
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("List workspace folders"))

    -- Document highlighting
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight') then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = highlight_augroup, buffer = event2.buf }
        end,
      })
      if client and client:supports_method('textDocument/documentHighlight') then
        map('n', '<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, opts('[T]oggle Inlay [H]ints'))
      end
    end
  end
})

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  }
}
-- disable semanticTokens
local on_init = function(client, _)
  if client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- Enhanced completion capabilities
local original_capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities(original_capabilities)
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- Lua-specific settings
local lua_lsp_settings = {
  Lua = {
    workspace = {
      library = {
        vim.fn.expand("$VIMRUNTIME/lua"),
        vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
        "${3rd}/luv/library",
      },
      checkThirdParty = false,
    },
  },
  telemetry = { enable = false },
}

-- Enable common language servers
local servers = { "html", "cssls", "clangd", "bashls", "texlab", "jdtls", "pylsp", "dotls", "lua_ls" }

vim.lsp.enable(servers)
vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })
vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
