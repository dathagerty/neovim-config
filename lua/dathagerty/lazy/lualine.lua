local function supermaven_status()
    return require("supermaven-nvim.api").is_running
end

local function supermaven()
    local status = "✗"
    if supermaven_status() then
        status = "✓"
    end
    return "supermaven: " .. status
end

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
					globalstatus = true
				},
				sections = {
                    lualine_a = {"mode"},
                    lualine_b = {"branch"},
                    lualine_c = {
                        "filename",
                        "location",
                    },
					lualine_x = {
                        {
                            -- TODO: make this section prettier (colors)
                            supermaven
                        }
					},
                    lualine_y = {
                        {
                            "diagnostics"
                        },
                        {
                            "searchcount",
                        },
                    },
                    lualine_z = {
                    },
				},
                tabline = {
                    lualine_a = {"buffers"},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {"tabs"},
                },
				-- TODO: customize sections
				-- remove file format, encoding, progress
				-- move diagnostics to right
				-- move location next to filename
			})
		end
	},
}
