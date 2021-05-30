vim.cmd([[let base16colorspace=256]])
vim.cmd([[set termguicolors]])
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd([[set background=dark]])
vim.cmd([[colorscheme gruvbox8_soft]])

local helpers = require('helpers')

helpers.hl("LspDiagnosticsDefaultError", { bg  = "NONE", fg = "#e95678" })
helpers.hl("LspDiagnosticsDefaultWarning", { bg  = "NONE", fg = "#e5c07b" })
helpers.hl("LspDiagnosticsDefaultInformation", { bg  = "NONE", fg = "#61afef" })
helpers.hl("LspDiagnosticsDefaultHint", { bg  = "NONE", fg = "#abcf84" })
helpers.hl("LspDiagnosticsUnderlineError", { fg = "NONE", gui = "undercurl", cterm = "undercurl" })
helpers.hl("LspDiagnosticsUnderlineWarning", { fg = "NONE", gui = "undercurl", cterm = "undercurl" })
helpers.hl("LspDiagnosticsUnderlineInformation", { fg = "NONE", gui = "undercurl", cterm = "undercurl" })
helpers.hl("LspDiagnosticsUnderlineHint", { fg = "NONE", gui = "undercurl", cterm = "undercurl" })

vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})


-- needs to be loaded after setting colourscheme
vim.cmd [[packadd nvim-web-devicons]]
require("nvim-web-devicons").setup {
  override = {
    svg = {
      icon  = "",
      color = "#ebdbb2",
      name  = "Svg",
    },
  },
  default = true,
}
