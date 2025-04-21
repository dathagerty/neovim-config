require("dathagerty")

local options = vim.o
-- hehehe
local global = vim.g

if vim.g.neovide then
	options.guifont = "VulfMono Nerd Font Light,Cascadia Code:h16"
    global.neovide_theme = "auto"
end

vim.cmd.colorscheme "catppuccin"
