local options = vim.opt
options.scrolloff = 8

options.termguicolors = true
options.background = 'dark'

options.number = true
options.relativenumber = true

options.colorcolumn = '80'
options.signcolumn = 'yes'

options.splitright = true
options.splitbelow = true

options.hlsearch = false
options.incsearch = true
options.ignorecase = true
options.smartcase = true

options.swapfile = false
options.backup = false
options.undodir = os.getenv("HOME") .. "/.vim/undodir"
options.undofile = true

options.vb = true

options.isfname:append("@-@")

options.tabstop = 4
options.softtabstop = 4
options.shiftwidth = 4
options.expandtab = true
