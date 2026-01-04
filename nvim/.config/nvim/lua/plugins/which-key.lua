return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local which_key = require("which-key")

		which_key.setup({
			win = {
				border = "rounded",
				padding = { 1, 2 },
				title = true,
				title_pos = "center",
			},

			layout = {
				align = "center",
			},

			plugins = {
				spelling = {
					enabled = true,
				},
			},
		})
	end,
}
