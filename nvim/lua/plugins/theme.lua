return {
	-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			require("gruvbox").setup({
				inverse = false,
				contrast = "hard",
			})
			vim.cmd.colorscheme("gruvbox") -- Set active colorscheme
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			})
			-- vim.cmd.colorscheme("tokyonight-night") -- Set active colorscheme
		end,
	},
}
