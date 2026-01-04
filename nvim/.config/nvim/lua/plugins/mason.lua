return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				ensure_installed = {
					"hadolint",
					"markdownlint-cli2",
					"markdown-toc",
					"js-debug-adapter",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ts_ls" },
				automatic_installation = true,
			})
		end,
	},
}
