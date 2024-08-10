vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines up"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines down"})

vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "replace text"})

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard"})
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank line to system clipboard" })

vim.keymap.set("n", "<leader>p", [["+p]], { desc = "paste from system clipboard" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "paste from system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete selection" })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "next error" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "previous error" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "next location" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "previous location" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- TODO: move this to an autogrp or autocmd for Go
vim.keymap.set(
	"n",
	"<leader>ee",
	"oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader><leader>", vim.cmd.so, { desc = "source config" })

vim.keymap.set("n", "<leader>fc", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
end)
vim.keymap.set("n", "<leader>fb", function()
	require("mini.files").open(nil, false)
end)

vim.keymap.set({"n", "v"}, "<C-h>", vim.cmd.nohlsearch, { desc = "clear search" })
vim.keymap.set("n", "<leader>?", function ()
	require("which-key").show({ global = false })
end, { desc = "buffer local keymaps" })

vim.keymap.set("n", "<leader>l", vim.cmd.Lazy, { desc = "lazy" })
