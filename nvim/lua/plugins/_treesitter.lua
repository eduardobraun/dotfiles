require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        disable = { "latex", "markdown" },
    },
    indent = {
        enable = true
    },
    matchup = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    playground = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        config = {
            lua = "-- %s",
        }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = ")",
            node_incremental = ")",
            -- scope_incremental = "grc",
            node_decremental = "(",
        },
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<Leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<Leader>A"] = "@parameter.inner",
            },
        },
        lsp_interop = {
            enable = true,
        },
    },
}
