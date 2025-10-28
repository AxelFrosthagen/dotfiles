return {
	"stevearc/oil.nvim",
	opts = {
		columns = {
			"icon",
			"permissions",
			"size",
			"mtime",
		},
		show_hidden = true,
		float = {
			padding = 5,
		},
		keymaps = {
			["<ESC>"] = { "actions.close", mode = "n" },
			["<C-g>"] = { "actions.close", mode = "n" },
			["g"] = { "actions.toggle_hidden", mode = "n" },
		},
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },

	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
