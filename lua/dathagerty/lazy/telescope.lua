return {
	{
		"nvim-telescope/telescope.nvim",
		version = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "olacin/telescope-cc.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "jvgrootveld/telescope-zoxide",
            "GianniBYoung/chezmoi-telescope.nvim",
            { url = "https://codeberg.org/elfahor/telescope-just.nvim" },
            {
                "pwntester/octo.nvim",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    "nvim-telescope/telescope.nvim",
                    "nvim-tree/nvim-web-devicons",
                },
                config = function()
                    require("octo").setup({
                        default_to_projects_v2 = true,
                        ui = {
                            use_signcolumn = false,
                        }
                    })
                end
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim", build = "make"
            },
		},
		config = function()
			require("telescope").setup {
				extensions = {
					file_browser = {
						hijack_netrw = true,
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({})
					},
                    conventional_commits = {
                        include_body_and_footer = true,
                    },
				},
			}
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("project")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("notify")
			require("telescope").load_extension("conventional_commits")
            require("telescope").load_extension("dap")
            require("telescope").load_extension("zoxide")
            require("telescope").load_extension("chezmoi")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>bp", function ()
                require("telescope").extensions.project.project({})
            end, { desc = "browse projects" })
            vim.keymap.set("n", "<leader>bf", builtin.find_files, { desc = "browse files" })
            vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "browse buffers" })
            vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "browse tracked files" })
            vim.keymap.set("n", "<leader>bws", function()
                local word = vim.fn.expand("<cword>")
                builtin.grep_string({ search = word })
            end, { desc = "find current word" })
            vim.keymap.set("n", "<leader>bWs", function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end, {desc = "find current WORD" })
            vim.keymap.set("n", "<leader>bs", builtin.live_grep, { desc = "search in files" })
            vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "browse vim help" })

            vim.keymap.set("n", "<leader>bd", require("telescope").extensions.zoxide.list, { desc = "browse directories" })
		end
	},
}
