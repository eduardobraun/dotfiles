vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.cmd('set inccommand=split') -- Make substitution work in realtime
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.o.title = true
TERMINAL = vim.fn.expand('$TERMINAL')
vim.cmd('let &titleold="'..TERMINAL..'"')
vim.o.titlestring="%<%F%=%l/%L - nvim"
vim.wo.wrap = false -- Display long lines as just one line
vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys
vim.cmd('syntax on') -- syntax highlighting
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.cmd('set ts=4')
vim.cmd('set sw=4')
vim.cmd('set expandtab')
vim.bo.smartindent = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.mapleader = ' '
vim.o.mouse = "a"
vim.o.conceallevel = 0
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
vim.o.showmode = false
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 500 -- By default timeoutlen is 1000 ms
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.cmd('filetype plugin on') -- filetype detection
vim.cmd('set listchars=tab:→\\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨')
vim.cmd('set list')
vim.cmd('let g:gitgutter_enabled = 1')
