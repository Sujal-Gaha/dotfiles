return {
	{
		-- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				markdown = { "markdownlint-cli2" },
				python = { "ruff" },
			}

			lint.linters.ruff = require("lint").linters.ruff or {}
			lint.linters.ruff.args = {
				"check",
				"--force-exclude",
				"--quiet",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
				"--output-format",
				"json",
				"--config",
				"line-length=120",
				"-",
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					if vim.bo.modifiable then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
