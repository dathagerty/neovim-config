vim.opt.scrolloff = 8

vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.vb = true

vim.opt.isfname:append("@-@")

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
