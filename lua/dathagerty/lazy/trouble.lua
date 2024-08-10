return {
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            local trouble = require("trouble")
            trouble.setup({})

            vim.keymap.set("n", "]d", function ()
                trouble.next({ skip_groups = true, jump= true })
            end, { desc = "next diagnostic (trouble)" })
            vim.keymap.set("n", "[d", function ()
                trouble.prev({ skip_groups = true, jump= true })
            end, { desc = "previous diagnostic (trouble)" })
            vim.keymap.set("n", "[D", function ()
                trouble.last({ skip_groups = true, jump= true })
            end, { desc = "last diagnostic (trouble)" })
            vim.keymap.set("n", "]D", function ()
                trouble.first({ skip_groups = true, jump= true })
            end, { desc = "first diagnostic (trouble)" })

            vim.keymap.set("n", "<leader>td", function ()
                trouble.toggle("diagnostics")
            end, { desc = "toggle trouble (diagnostics)" })
            vim.keymap.set("n", "<leader>tL", function ()
                trouble.toggle("loclist")
            end, { desc = "toggle trouble (loclist)" })
            vim.keymap.set("n", "<leader>tl", function ()
                trouble.toggle("lsp")
            end, { desc = "toggle trouble (lsp)" })
            vim.keymap.set("n", "<leader>tq", function ()
                trouble.toggle("quickfix")
            end, { desc = "toggle trouble (quickfix)" })
        end,
	},
	{
		'folke/todo-comments.nvim',
        event = { "BufReadPre", "BufNewFile" },
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {},
        config = function ()
            local todo_comments = require("todo-comments")
            todo_comments.setup({})
            local telescope = require("telescope")
            telescope.load_extension("todo-comments")

            vim.keymap.set("n", "<leader>bt", function ()
                telescope.extensions["todo-comments"].todo()
            end, { desc = "browse todos" })
        end
	},
}
