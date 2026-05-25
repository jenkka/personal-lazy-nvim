return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-mini/mini.icons" },
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({
            "default",
            fzf_opts = { ["--layout"] = "reverse" },
            winopts = { preview = { default = "builtin" } },
        })
        fzf.register_ui_select() -- Replaces telescope-ui-select

        vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'Live grep' })
        vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'Buffers' })
        vim.keymap.set('n', '<leader>fs', fzf.git_status, { desc = 'Git status (changed files)' })
        vim.keymap.set('n', '<leader>fd', fzf.diagnostics_workspace, { desc = 'Workspace diagnostics' })
    end,
}
