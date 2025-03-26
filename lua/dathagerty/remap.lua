vim.g.mapleader = " "

local keymaps = vim.keymap

keymaps.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines up"})
keymaps.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines down"})

keymaps.set("n", "J", "mzJ`z", { desc = "join lines" })
keymaps.set("n", "<C-d>", "<C-d>zz")
keymaps.set("n", "<C-u>", "<C-u>zz")
keymaps.set("n", "n", "nzzzv")
keymaps.set("n", "N", "Nzzzv")

-- greatest remap ever
keymaps.set("x", "<leader>p", [["_dP]], { desc = "replace text"})

-- next greatest remap ever : asbjornHaland
keymaps.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard"})
keymaps.set("n", "<leader>Y", [["+Y]], { desc = "yank line to system clipboard" })

keymaps.set("n", "<leader>p", [["+p]], { desc = "paste from system clipboard" })
keymaps.set("n", "<leader>P", [["+P]], { desc = "paste from system clipboard" })

keymaps.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete selection" })

keymaps.set("n", "Q", "<nop>")

keymaps.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "next error" })
keymaps.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "previous error" })
keymaps.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "next location" })
keymaps.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "previous location" })

keymaps.set("n", "<leader>s", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])
keymaps.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make executable" })

-- TODO: move this to an autogrp or autocmd for Go
keymaps.set(
	"n",
	"<leader>ee",
	"oif err != nil {<CR>}<Esc>Oreturn err<Esc>",
    { desc = "go error" }
)

keymaps.set("n", "<leader><leader>", vim.cmd.so, { desc = "source config" })

keymaps.set("n", "<leader>fc", function()
	require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
end, { desc = "browse current directory" })
keymaps.set("n", "<leader>fb", function()
	require("mini.files").open(nil, false)
end, { desc = "browse working directory" })

keymaps.set({"n", "v"}, "<C-h>", vim.cmd.nohlsearch, { desc = "clear search" })
keymaps.set("n", "<leader>?", function ()
	require("which-key").show({ global = false })
end, { desc = "buffer local keymaps" })

keymaps.set("n", "<leader>l", vim.cmd.Lazy, { desc = "lazy" })
