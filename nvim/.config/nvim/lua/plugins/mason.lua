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
			})

			local mr = require("mason-registry")
			local ensure_installed = {
				"prettier",
				"stylua",
				"black",
				"shfmt",
				"markdownlint-cli2",
				"tree-sitter-cli",
			}
			mr.refresh(function()
				for _, tool in ipairs(ensure_installed) do
					local ok, p = pcall(mr.get_package, tool)
					if ok and not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright", "ts_ls", "ruff" },
				automatic_installation = true,
			})
		end,
	},
}
