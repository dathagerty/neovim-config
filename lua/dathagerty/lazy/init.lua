return {
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {},
	},
	{
		'folke/neoconf.nvim',
		lazy = false,
		priority = 900,
	},
	{
		'folke/neodev.nvim',
		opts = {
			library = {
				plugins = { 'nvim-dap-ui' },
				types = true,
			}
		}
	},
}
