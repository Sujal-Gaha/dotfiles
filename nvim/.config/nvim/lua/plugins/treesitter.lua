return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master", -- Critical: Use the stable branch
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"python",
				"vim",
				"vimdoc",
				"query",
				"bash",
				"markdown",
				"markdown_inline",
				"javascript",
				"typescript",
				"dockerfile",
				"sql",
				"astro",
			}, -- Add languages you want
			auto_install = true, -- Automatically install missing parsers
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			-- Add other modules if needed, e.g., incremental_selection = { enable = true }
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
