return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			local ensure_installed = {
				"bash",
				"c",
				"diff",
				"go",
				"dockerfile",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			}
			ts.install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				desc = "Enable Treesitter highlighting",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}
