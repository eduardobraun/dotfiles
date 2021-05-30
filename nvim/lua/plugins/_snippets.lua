local ls = require("luasnip")

ls.snippets = {
  all = {},
}

vim.api.nvim_set_keymap(
  "i",
  "<C-j>",
  [[<Cmd>lua require'helpers'.luasnip_jump()<CR>]],
  { silent = true, noremap = true }
)
