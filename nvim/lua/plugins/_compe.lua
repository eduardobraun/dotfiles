vim.g.loaded_compe_snippets_nvim = 1
vim.g.loaded_compe_spell         = 1
vim.g.loaded_compe_tags          = 1
vim.g.loaded_compe_treesitter    = 1
vim.g.loaded_compe_emoji         = 1
vim.g.loaded_compe_omni          = 1
vim.g.loaded_compe_vsnip         = 1
vim.g.loaded_compe_ultisnips     = 1
vim.g.loaded_compe_vim_lsc       = 1
vim.g.loaded_compe_calc          = 1

vim.o.completeopt = "menuone,noselect"
require("compe").setup {
    enable = true,
    preselect = "disable",
    source = {
        path = true,
        buffer = true,
        luasnip = true,
        nvim_lua = true,
        nvim_lsp = {
            enable = true,
            priority = 10001,
        },
    }
}

vim.api.nvim_set_keymap(
  "i",
  "<CR>",
  [[<Cmd>lua require'helpers'.trigger_completion()<CR>]],
  { silent = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<Tab>",
  table.concat({
    "pumvisible() ? \"<C-n>\" : v:lua.require('helpers').check_backspace()",
    "? \"<Tab>\" : compe#confirm()",
  }),
  { silent = true, noremap = true, expr = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<S-Tab>",
  "pumvisible() ? \"<C-p>\" : \"<S-Tab>\"",
  { noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<C-Space>",
  "compe#complete()",
  { noremap = true, expr = true, silent = true }
)
