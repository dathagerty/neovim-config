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
        config = true,
	},
	{
		'akinsho/git-conflict.nvim',
		version = "*",
        config = true,
	},
	{
		'lewis6991/gitsigns.nvim',
        config = true,
	},
	{
		'notjedi/nvim-rooter.lua',
		config = function()
			require('nvim-rooter').setup()
		end
	},
}
