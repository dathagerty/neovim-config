local km = vim.keymap
local k = vim.keycode

vim.g.mapleader = " "

-- move lines and respect indents
km.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected lines up" })
km.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected lines down" })

km.set("n", "J", "mzJ`z", { desc = "join lines" })
km.set("n", "<C-d>", "<C-d>zz", { desc = "page down & center" })
km.set("n", "<C-u>", "<C-u>zz", { desc = "page up & center" })
km.set("n", "n", "nzzzv", { desc = "next search term & center" })
km.set("n", "N", "Nzzzv", { desc = "previous search term & center" })

-- greatest remap ever
km.set("x", "<leader>p", [["_dP]], { desc = "replace text" })

-- next greatest remap ever : asbjornHaland
km.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard" })
km.set("n", "<leader>Y", [["+Y]], { desc = "yank line to system clipboard" })

km.set("n", "<leader>p", [["+p]], { desc = "paste from system clipboard" })
km.set("n", "<leader>P", [["+P]], { desc = "paste from system clipboard" })

km.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete selection" })

km.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "next error" })
km.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "previous error" })
km.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "next location" })
km.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "previous location" })

km.set("n", "<leader>s", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace word under cursor" })
km.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make executable" })

km.set("n", "<leader><leader>d", function ()
    Snacks.dashboard({ example = "advanced" })
end, { desc = "open dashboard" })

-- Toggle hlsearch if it's on, otherwise just do "enter"
km.set("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.v.hlsearch == 1 then
    vim.cmd.nohl()
    return ""
  else
    return k "<CR>"
  end
end, { expr = true })

km.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "buffer local keymap" })

km.set("n", "<leader>l", vim.cmd.Lazy, { desc = "lazy" })
