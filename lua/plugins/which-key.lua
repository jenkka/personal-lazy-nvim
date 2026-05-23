return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        require('which-key').setup({
            delay = 500,
        })
    end,
}
