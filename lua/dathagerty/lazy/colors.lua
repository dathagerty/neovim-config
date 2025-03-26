return {
	{
		'ellisonleao/gruvbox.nvim',
		lazy = false,
		priority = 1000,
		name = 'gruvbox',
		config = function()
			require('gruvbox').setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = false,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = true,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = 'hard', -- can be 'hard', 'soft' or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			-- vim.cmd.colorscheme('gruvbox')
		end,
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		config = function ()
            require("catppuccin").setup({
                integrations = {
                    fidget = true,
                    lsp_trouble = true,
                    mason = true,
                    neotest = true,
                    noice = true,
                    notify = true,
                    octo = true,
               }
            })
			vim.cmd.colorscheme('catppuccin')
		end
	},
    {
        'shaunsingh/nord.nvim',
        priority = 1000,
        config = function ()
            -- vim.cmd.colorscheme('nord')
        end
    },
}
