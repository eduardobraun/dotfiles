vim.cmd([[let base16colorspace=256]])
vim.cmd([[set termguicolors]])
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd([[set background=dark]])

vim.cmd("colorscheme nightfox")

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
