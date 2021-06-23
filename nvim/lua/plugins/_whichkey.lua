local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    f = {
      name = "+file",
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      n = { "<cmd>enew<cr>", "New File" },
    },
  },
})

wk.register({
  ["<leader>"] = {
    c = {
      name = "+code",
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      d = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
      D = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
      k = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature" },
      K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
    },
  },
})

wk.register({
  ["<leader>"] = {
    w = {
      name = "+window",
      s = { "<cmd>split<cr>", "Split" },
      v = { "<cmd>vsplit<cr>", "Split Vertical" },
      c = { "<cmd>close<cr>", "Close" },
      h = { "<C-W><C-h>", "Left" },
      j = { "<C-W><C-j>", "Down" },
      k = { "<C-W><C-k>", "Up" },
      l = { "<C-W><C-l>", "Right" },
    },
  },
})
