return {
    {
        "ThePrimeagen/99",
        config = function()
            local _99 = require("99")

            _99.setup({
                provider = _99.Providers.ClaudeCodeProvider,
            })

            vim.keymap.set("v", "<leader>9v", function() _99.visual() end,
                { desc = "99: edit selection" })
            vim.keymap.set("n", "<leader>9s", function() _99.search() end,
                { desc = "99: project search" })
            vim.keymap.set("n", "<leader>9x", function() _99.stop_all_requests() end,
                { desc = "99: cancel requests" })
            vim.keymap.set("n", "<leader>9o", function() _99.open() end,
                { desc = "99: view last result" })
        end,
    },
    {
        "coder/claudecode.nvim",
        opts = {
            terminal = {
                provider = "native",
            },
        },
        keys = {
            { "<leader>a",  nil,                              desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                       desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
        },
    },
}
