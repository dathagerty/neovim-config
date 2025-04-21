return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "AndreM222/copilot-lualine"
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            highlight_headers = false,
            separator = '---',
            error_header = '> [!ERROR] Error',
        },
        cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatToggle" },
        keys = {
            {
                "<leader>io",
                function()
                    require("CopilotChat").open({
                        window = {
                            width = 0.3
                        }
                    })
                end,
                desc = "Open Copilot Chat"
            },
            {
                "<leader>ic",
                function()
                    require("CopilotChat").open({
                        window = {
                            layout = "float",
                            relative = 'cursor',
                            height = 0.2,
                            width = 1,
                            row = 1
                        }
                    })
                end,
                desc = "Toggle Inline Chat"
            },
            {
                "<leader>ig",
                function ()
                    local chat = require("CopilotChat")
                    local commit_prompt = chat.prompts().Commit
                    chat.ask(commit_prompt.prompt, { context = commit_prompt.context })
                end
            },
        },
    },
}
