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
        "folke/lazydev.nvim",
        ft = "lua",
        dependencies = {
            "justinsgithub/wezterm-types",
        },
        opts = {
            library = {
                { path = "wezterm-types", mods = { "wezterm" } },
            },
        },
    },
}
