return {
    -- TODO: set up good keybindings for debugger
    -- https://github.com/fredrikaverpil/neotest-golang
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-neotest/nvim-nio'
		}
	},
	{
		'theHamsta/nvim-dap-virtual-text',
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-treesitter/nvim-treesitter'
		},
		config = function()
			require('nvim-dap-virtual-text').setup {}
		end,
	},
    {
        "leoluz/nvim-dap-go",
        opts = {},
    },
}
