return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "bashls",
                    "gopls",
                    "ts_ls",
                },
            })
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "stylua",
                    "shfmt",
                    "prettier",
                    "ruff",
                    "goimports",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable({
                "lua_ls",
                "pyright",
                "bashls",
                "gopls",
                "ts_ls",
            })

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "LSP hover" })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to implementation" })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "Go to references" })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
        end
    }
}
