-- require'lsp_extensions'.inlay_hints{
--     highlight = "Comment",
--     prefix = " => ",
--     aligned = false,
--     only_current_line = false,
--     enabled = { "ChainingHint" }
-- }

local function printdot(err, method, result, client_id, bufnr, config)
    local api = vim.api
    if err ~= nil then
        return err
    end

    print(vim.inspect(result))
    -- print(vim.inspect(method))
    local buf = api.nvim_create_buf(false, true) -- create new emtpy buffer

    api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    -- get dimensions
    local width = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")

    -- calculate our floating window size
    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(width * 0.8)

    -- and its starting position
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    -- set some options
    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }

    -- and finally create it with buffer attached
    local win = api.nvim_open_win(buf, true, opts)

    local lines = {}
    for l in vim.gsplit(result, "\n") do
        table.insert(lines, l)
    end

    -- print(vim.inspect(lines))
    api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

local lsp_config = {
  on_attach = _G.lsp_on_attach,
  handlers = {},
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  },
}

lsp_config.handlers["rust-analyzer/viewCrateGraph"] = printdot

local opts = {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler
        -- default: true
        hover_with_actions = true,

        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = true

            -- rest of the opts are forwarded to telescope
        },

        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<-",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix  = "=>",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
              {"╭", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╮", "FloatBorder"},
              {"│", "FloatBorder"},
              {"╯", "FloatBorder"},
              {"─", "FloatBorder"},
              {"╰", "FloatBorder"},
              {"│", "FloatBorder"}
            },
        }
    },

    server = lsp_config, -- rust-analyer options
}

require('rust-tools').setup(opts)

--vim.api.nvim_exec([[
--autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs lua require'rust-tools.inlay_hints'.set_inlay_hints()
--]], false)
