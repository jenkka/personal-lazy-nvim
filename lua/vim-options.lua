-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic settings
vim.opt.mouse = "" -- Turn off mouse

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smartindent = true -- Neovim's equivalent for better indenting

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Make background transparent (inherits terminal opacity / bg image)
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local groups = {
			"Normal", -- main buffer (current window)
			"NormalNC", -- main buffer (inactive windows -- fixes split transparency)
			"NormalFloat", -- floating windows
			"EndOfBuffer", -- '~' lines past end of file
			"SignColumn", -- gutter where diagnostic/git signs live
			"LineNr", -- line numbers
			"NonText", -- listchars markers (>·, █, ␣) and similar
		}
		for _, g in ipairs(groups) do
			vim.api.nvim_set_hl(0, g, { bg = "NONE" })
		end
		-- Dim listchars (tab >·, trail █, nbsp ␣) so they don't dominate
		vim.api.nvim_set_hl(0, "Whitespace", { fg = "#3a3a44", bg = "NONE" })
		vim.api.nvim_set_hl(0, "NonText", { fg = "#3a3a44", bg = "NONE" })
	end,
})

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 200

vim.opt.colorcolumn = "81"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline" -- keeps showcmd out of the cursor area
vim.opt.showmatch = true
vim.opt.history = 1000
vim.opt.cursorline = true

vim.opt.spelllang = "en_us"

-- Enable spell-check only in text-y filetypes (off in code).
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- JS/TS family: 2-space indent (replaces per-language ftplugin files).
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function()
		vim.bo.expandtab = true
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
		vim.bo.shiftwidth = 2
	end,
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

vim.opt.list = true
vim.opt.listchars = { tab = ">·", trail = "█", nbsp = "␣" }

-- Open explorer
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Ctrl+c is the new Esc!
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Toggle search highlighting
vim.keymap.set("n", "<leader>h", ":set hlsearch!<CR>", { desc = "Toggle search highlight" })

-- Bindings for easy split navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Append line below without moving cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })

-- Center word lookup
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

-- Paste without overriding current buffer
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- Copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Turn off this garbage
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q" })

vim.keymap.set(
	"n",
	"<leader>cp",
	":lua ToggleCopyGarbage()<CR>",
	{ noremap = true, silent = true, desc = "Toggle copy mode" }
)

-- Show diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show LSP diagnostic" })

-- Toggle garbage when copying text
local copyGarbage = true
function ToggleCopyGarbage()
	if copyGarbage then
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.opt.signcolumn = "no"
		vim.opt.list = false
		vim.opt.spell = false
	else
		vim.opt.number = true
		vim.opt.relativenumber = true
		vim.opt.signcolumn = "yes"
		vim.opt.list = true
		vim.opt.spell = true
	end
	copyGarbage = not copyGarbage
end
