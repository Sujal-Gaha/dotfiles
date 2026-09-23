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
				go = { "golangci-lint" },
				}

			lint.linters["markdownlint-cli2"] = lint.linters["markdownlint-cli2"] or {}
		lint.linters["markdownlint-cli2"].args = {
			"--config",
			vim.fn.expand("~/.markdownlint.json"),
			"--stdin-filename",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
			"-",
		}

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
					if not vim.bo.modifiable then
						return
					end

					local names = lint._resolve_linter_by_ft(vim.bo.filetype)
					local valid_names = {}
					for _, name in ipairs(names) do
						local linter = lint.linters[name]
						if type(linter) == "function" then
							linter = linter()
						end
						if linter and linter.cmd then
							local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
							if cmd and vim.fn.executable(cmd) == 1 then
								table.insert(valid_names, name)
							end
						end
					end

					if #valid_names > 0 then
						lint.try_lint(valid_names, { ignore_errors = true })
					end
				end,
			})
		end,
	},
}
