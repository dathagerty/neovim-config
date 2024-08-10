return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"fredrikaverpil/neotest-golang",
		},
		config = function ()
			require("neotest").setup({
				adapters = {
					require("neotest-golang")(
						{
							go_test_args = {
                                "-v",
                                "-race",
                                "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",}
						}
					)
				},
			})
            vim.keymap.set("n", "<leader>Tc", function ()
                require("neotest").run.run()
            end, { desc = "run nearest test" })
            vim.keymap.set("n", "<leader>TC", function ()
                require("neotest").run.run(vim.fn.expand("%"))
            end, { desc = "run all tests in file" })
            vim.keymap.set("n", "<leader>Td", function ()
                require("neotest").run.run({ strategy = "dap" })
            end, { desc = "debug nearest test" })
            vim.keymap.set("n", "<leader>Ts", function ()
                require("neotest").summary.toggle()
            end, { desc = "show test suite summary" })
		end
	},
    {
        "andythigpen/nvim-coverage",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = true,
    },
}
