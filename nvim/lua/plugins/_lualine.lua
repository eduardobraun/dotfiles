local lualine = require 'lualine'

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

local diff_cmp = {
  'diff',
  symbols = {added = ' ', modified = '柳 ', removed = ' '},
  condition = conditions.hide_in_width
}
-- Config
local config = {
  options = {
    section_separators = "",
    theme = "nightfox",
  },
  sections = {
    lualine_b = {'branch', diff_cmp},
    lualine_c = {'filename', require'lsp-status'.status},
  },
  extensions = {'quickfix', 'fugitive'},
}

lualine.setup(config)
