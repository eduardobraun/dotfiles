local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').texlab.setup {
  on_attach = _G.lsp_on_attach,
 capabilities = capabilities
}
