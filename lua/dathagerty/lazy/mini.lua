return {
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			require('mini.ai').setup()
            -- TODO: determine if this is needed/what I can bring in that I like
			require('mini.basics').setup()
			require('mini.bracketed').setup()
			require('mini.comment').setup()
			require('mini.cursorword').setup()
			require('mini.extra').setup()
			require('mini.files').setup({
				options = {
					permanent_delete = false,
				},
				windows = {
					preview = true,
				},
			})
			require('mini.hipatterns').setup({
				highlighters = {
					hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
				}
			})

			local map = require('mini.map')
            map.setup()
			-- require('mini.pairs').setup()
			-- require('mini.starter').setup()
			require('mini.surround').setup()
			-- require('mini.tabline').setup()

            vim.keymap.set('n', '<leader>M', map.toggle)
		end
	},
}
