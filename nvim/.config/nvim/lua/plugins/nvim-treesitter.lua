return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		ensure_installed = {
			"python",
			"typescript",
			"go",
			"lua",
			"bash",
			"javascript",
			"jsx",
			"tsx",
			"json",
		},
		highlight = {
			enable = true,
		},
	},
}
