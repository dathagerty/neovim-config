return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
		keys = {
			{ '<c-space>', desc = 'Increment Selection' },
			{ '<bs>',      desc = 'Decrement Selection', mode = 'x' },
		},
		config = function()
			local configs = require('nvim-treesitter.configs')
			configs.setup({
				ensure_installed = {
					'bash',
					'c',
					'diff',
					'html',
					'javascript',
					'jsdoc',
					'json',
					'jsonc',
					'lua',
					'luadoc',
					'luap',
					'markdown',
					'markdown_inline',
					'python',
					'query',
					'regex',
					'toml',
					'tsx',
					'typescript',
					'vim',
					'vimdoc',
					'xml',
					'yaml',
					'rust',
					'go',
					'gosum',
					'gomod',
					'gowork',
					'gotmpl',
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<C-space>',
						node_incremental = '<C-space>',
						scope_incremental = false,
						node_decremental = '<bs>',
					},
				},
				textobjects = {
					move = {
						enable = true,
						goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
						goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
						goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
						goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
					},
				},
				highlight = { enable = true },
				indent = { enable = true },
				matchup = { enable = true },
			})
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		event = 'BufEnter',
		enabled = true,
		opts = { mode = 'cursor', max_lines = 3 },
		keys = {
			{
				'<leader>ut',
				function()
					local tsc = require('treesitter-context')
					tsc.toggle()
				end,
				desc = 'Toggle Treesitter Context',
			},
		},
	},
	{
		'windwp/nvim-ts-autotag',
		event = 'BufEnter *.html',
	},
	{
		'andymass/vim-matchup',
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = 'popup' }
		end
	},
}
