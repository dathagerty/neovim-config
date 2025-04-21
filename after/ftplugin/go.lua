local set = vim.opt_local
local km = vim.keymap

set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4

-- TODO: is this necessary? this might be available in an LSP snippet
-- or it should just be a snippet I make myself.
km.set(
    { "n", "i" },
    "<leader><leader>e",
    "oif err != nil {<CR>}<Esc>Oreturn fmt.Errorf(\": %w\", err)<Esc>5be",
    { desc = "go error" }
)
