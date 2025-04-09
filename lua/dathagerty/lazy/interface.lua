return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            dashboard = {
                enabled = true,
                example = 'advanced',
            },
            dim = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            -- input = { enabled = true },
            lazygit = { enabled = true },
            picker = { enabled = true },
            -- notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            zen = { enabled = true },
        },
        keys = {
            { "<leader>fb", function() Snacks.picker.files() end,         desc = "browse working directory" },
            { "<leader>fe", function() Snacks.explorer() end,             desc = "file explorer" },
            { "<leader>bt", function() Snacks.picker.todo_comments() end, desc = "browse todos" },
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
                    Snacks.toggle.option("conceallevel",
                        { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>tc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                    "<leader>tb")
                    Snacks.toggle.inlay_hints():map("<leader>th")
                    Snacks.toggle.indent():map("<leader>tg")
                    Snacks.toggle.dim():map("<leader>tD")
                end,
            })
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            local function harpoon_picker()
                local file_paths = {}
                for _, item in ipairs(harpoon:list().items) do
                    table.insert(file_paths, {
                        text = item.value,
                        file = item.value,
                    })
                end
                return file_paths
            end

            local k = vim.keymap
            k.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "add to harpoon" })
            k.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "toggle harpoon" })
            k.set("n", "<leader>fh", function()
                Snacks.picker({
                    finder = harpoon_picker,
                })
            end, { desc = "browse harpoon" })

            k.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "harpoon 1" })
            k.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "harpoon 2" })
            k.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "harpoon 3" })
            k.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "harpoon 4" })

            -- Toggle previous & next buffers stored within Harpoon list
            k.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "previous harpoon" })
            k.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "next harpoon" })
        end
    },
}
