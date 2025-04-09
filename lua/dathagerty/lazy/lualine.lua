return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		config = function()
			vim.opt.showmode = false
			require("lualine").setup({
				options = {
					component_separators = "",
					section_separators = { left = "", right = "" },
					theme = "catppuccin",
					globalstatus = true,
                    extensions = { "lazy", "fugitive", "mason" },
				},
				sections = {
                    lualine_a = {
                        {
                            "mode"
                        },
                    },
                    lualine_b = {
                        {
                            "branch",
                            on_click = function ()
                                vim.cmd.Git()
                            end,
                        },
                        {
                            "diff",
                            symbols = {
                                added = " ",
                                modified = " ",
                                removed = " ",
                            },
                        },
                    },
                    lualine_c = {
                        "location",
                        "filename",
                    },
					lualine_x = {
                        {
                            "copilot",
                            show_colors = true,
                        },
                        {
                            "searchcount",
                        },
                        {
                            require("lazy.status").updates,
                            cond = require("lazy.status").has_updates,
                        },
					},
                    lualine_y = {
                        {
                            "diagnostics",
                            always_visible = true,
                            sources = { "nvim_diagnostic" },
                            on_click = function ()
                                Snacks.picker.diagnostics()
                            end
                        },
                        {
                            "filetype",
                        },
                    },
                    lualine_z = {
                        {
                            "datetime",
                            style = "iso"
                        },
                    },
				},
                tabline = {
                    lualine_a = {"tabs"},
                    lualine_b = {"buffers"},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {
                        function ()
                            local ok, pomo = pcall(require, "pomo")
                            if not ok then
                                return ""
                            end
                            local timer = pomo.get_first_to_finish()
                            if timer == nil then
                                return ""
                            end
                            return "󰄉 " .. tostring(timer)
                        end
                    },
                },
                winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
				-- TODO: customize sections
				-- remove file format, encoding, progress
				-- move diagnostics to right
				-- move location next to filename
			})
		end
	},
}
