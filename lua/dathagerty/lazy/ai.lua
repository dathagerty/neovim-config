return {
    {
        -- TODO: add a lualine status item
        "supermaven-inc/supermaven-nvim",
        config = function()
            require("supermaven-nvim").setup({
                disable_inline_completion = true,
            })
            vim.keymap.set("n", "<leader>at", require("supermaven-nvim.api").toggle, { desc = "toggle supermaven" })
        end,
    },
}
