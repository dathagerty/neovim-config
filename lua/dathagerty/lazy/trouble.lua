return {
    {
        -- TODO: figure out what to do with this thing
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            auto_close = true,
        },
        config = function()
            local trouble = require("trouble")

            vim.api.nvim_create_autocmd("QuickFixCmdPost", {
                callback = function()
                    vim.cmd([[Trouble qflist open]])
                end,
            })

            vim.keymap.set("n", "<leader>cd", function() trouble.toggle("diagnostics") end,
                { desc = "toggle trouble (diagnostics)" })

            vim.keymap.set("n", "<leader>cL", function() trouble.toggle("loclist") end,
                { desc = "toggle trouble (loclist)" })

            vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                { desc = "toggle trouble (lsp)" })

            vim.keymap.set("n", "<leader>cq", function() trouble.toggle("quickfix") end,
                { desc = "toggle trouble (quickfix)" })
        end,
    },
    {
        'folke/todo-comments.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        config = function()
            local todo = require("todo-comments")
            todo.setup({})
            local telescope = require("telescope")
            telescope.load_extension("todo-comments")

            vim.keymap.set("n", "<leader>bt", function()
                telescope.extensions["todo-comments"].todo()
            end, { desc = "browse todos" })
        end
    },
}
