return {
	{
		"linux-cultist/venv-selector.nvim",
		cmd = "VenvSelect",
		opts = {
			options = {
				notify_user_on_venv_activation = true,
			},
		},
		--  Call config for Python files and load the cached venv automatically
		ft = "python",
		keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function(args)
					local bufname = vim.api.nvim_buf_get_name(args.buf)
					if bufname == "" then
						return
					end
					local dir = vim.fs.dirname(bufname)
					local venv_dir = vim.fs.find({ ".venv", "venv" }, {
						path = dir,
						upward = true,
						type = "directory",
					})[1]
					if venv_dir then
						local py_bin = venv_dir .. "/bin/python"
						if vim.fn.filereadable(py_bin) ~= 1 then
							py_bin = venv_dir .. "/Scripts/python.exe"
						end
						if vim.fn.filereadable(py_bin) == 1 then
							vim.env.VIRTUAL_ENV = venv_dir
							local bin_dir = venv_dir .. "/bin"
							if
								vim.fn.isdirectory(bin_dir) == 1
								and not string.find(vim.env.PATH or "", bin_dir, 1, true)
							then
								vim.env.PATH = bin_dir .. ":" .. (vim.env.PATH or "")
							end
							vim.schedule(function()
								local ok, vs = pcall(require, "venv-selector")
								if ok and vs and vs.python and vs.python() ~= py_bin then
									pcall(vs.activate_from_path, py_bin, "venv")
								end
							end)
						end
					end
				end,
			})
		end,
	},
}
