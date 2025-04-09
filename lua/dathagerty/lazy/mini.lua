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
			require('mini.hipatterns').setup({
				highlighters = {
					hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
				}
			})

			require('mini.map').setup()
			require('mini.surround').setup()
            require('mini.sessions').setup({
                autoread = true,
            })
		end
	},
}
