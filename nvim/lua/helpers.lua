local function hl(group, opts)
    local bg     = opts.bg == nil and "" or "guibg=" .. opts.bg
    local fg     = opts.fg == nil and "" or "guifg=" .. opts.fg
    local gui    = opts.gui == nil and "" or "gui=" .. opts.gui
    local guisp  = opts.guisp == nil and "" or "guisp=" .. opts.guisp
    local cterm  = opts.cterm == nil and "" or "cterm=" .. opts.cterm
    local link   = opts.link or false

    if not link then
        vim.cmd(string.format("hi %s %s %s %s %s %s", group, bg, fg, gui, guisp, cterm))
    else
        vim.cmd(string.format("hi! link %s %s", group, link))
    end
end

local function t(cmd)
  return vim.api.nvim_replace_termcodes(cmd, true, true, true)
end

local function is_git_repo (cwd)
  local fd = vim.loop.fs_scandir(cwd)
  if fd then
    while true do
      local name, typ = vim.loop.fs_scandir_next(fd)
      if name == nil then return false end
      if typ == 'directory' and name == '.git' then return true end
    end
  end
end

local function trigger_completion()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"]()
    end
  end

   local prev_col, next_col = vim.fn.col(".") - 1, vim.fn.col(".")
  local prev_char = vim.fn.getline("."):sub(prev_col, prev_col)
  local next_char = vim.fn.getline("."):sub(next_col, next_col)

  -- minimal autopairs-like behaviour
  if prev_char == "{" and next_char ~= "}" then return Util.t("<CR>}<C-o>O") end
  if prev_char == "[" and next_char ~= "]" then return Util.t("<CR>]<C-o>O") end
  if prev_char == "(" and next_char ~= ")" then return Util.t("<CR>)<C-o>O") end
  if prev_char == ">" and next_char == "<" then return Util.t("<CR><C-o>O") end -- html indents
  if prev_char == "(" and next_char == ")" then return Util.t("<CR><C-o>O") end -- flutter indents

  return t("<CR>")
end

local function check_backspace()
  local curr_col = vim.fn.col(".")
  local is_first_col = vim.fn.col(".") - 1 == 0
  local prev_char = vim.fn.getline("."):sub(curr_col - 1, curr_col - 1)

  if is_first_col or prev_char:match("%s") then
    return true
  else
    return false
  end
end

local function luasnip_jump()
    local ls = require('luasnip')
    return ls.expand_or_jumpable() and ls.expand_or_jump() or require('helpers').t("<C-j>")
end

local M = {
    hl = hl,
    t = t,
    is_git_repo = is_git_repo,
    trigger_completion = trigger_completion,
    check_backspace = check_backspace,
    luasnip_jump = luasnip_jump,
}
return M
