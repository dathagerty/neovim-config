return {
	{
		'tpope/vim-fugitive',
		config = function ()
			vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
            vim.keymap.set("n", "<leader>gp", vim.cmd.Git)
		end
	},
	{
		'ThePrimeagen/git-worktree.nvim',
	},
	{
		'akinsho/git-conflict.nvim',
		version = "*",
	},
	{
		'lewis6991/gitsigns.nvim',
	},
	{
		'notjedi/nvim-rooter.lua',
		config = function()
			require('nvim-rooter').setup()
		end
	},
}
