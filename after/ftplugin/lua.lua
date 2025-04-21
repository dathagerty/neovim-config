local km = vim.keymap

km.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "execute file (lua)" })
km.set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "execute line (lua)" })
