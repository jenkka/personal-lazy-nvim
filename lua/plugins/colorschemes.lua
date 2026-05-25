return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = { transparency = true },
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
	-- {
	--     "bluz71/vim-moonfly-colors",
	--     name = "moonfly",
	--     lazy = false,
	--     priority = 1000,
	--     config = function()
	--         vim.cmd("colorscheme moonfly")
	--     end,
	-- },
	-- {
	--     "catppuccin/nvim",
	--     lazy = false,
	--     name = "catppuccin",
	--     priority = 1000,
	--     config = function()
	--         vim.cmd.colorscheme "catppuccin"
	--     end
	-- },
}
