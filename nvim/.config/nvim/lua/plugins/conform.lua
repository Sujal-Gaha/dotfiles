return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				python = { "black" },
				sh = { "shfmt" },
				bash = { "shfmt" },
			},

			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = false,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			require("conform").format()
		end, { desc = "Format file" })
	end,
}
