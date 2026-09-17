return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
			"folke/neoconf.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local function find_python_venv(start_dir)
				if not start_dir or start_dir == "" then
					return nil, nil
				end
				local venv_dir = vim.fs.find({ ".venv", "venv" }, {
					path = start_dir,
					upward = true,
					type = "directory",
				})[1]
				if venv_dir then
					local py_bin = venv_dir .. "/bin/python"
					if vim.fn.filereadable(py_bin) == 1 then
						return py_bin, venv_dir
					end
					local py_win = venv_dir .. "/Scripts/python.exe"
					if vim.fn.filereadable(py_win) == 1 then
						return py_win, venv_dir
					end
				end
				return nil, nil
			end

			local server_configs = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				pyright = {
					root_markers = {
						{
							"pyproject.toml",
							"setup.py",
							"setup.cfg",
							"requirements.txt",
							"Pipfile",
							"pyrightconfig.json",
							".venv",
							"venv",
						},
						".git",
					},
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
					before_init = function(_, config)
						local py_bin, venv_dir = find_python_venv(config.root_dir)
						if py_bin then
							config.settings = config.settings or {}
							config.settings.python = config.settings.python or {}
							if not config.settings.python.pythonPath then
								config.settings.python.pythonPath = py_bin
							end
							local venv_name = vim.fs.basename(venv_dir)
							local venv_parent = vim.fs.dirname(venv_dir)
							config.settings.python.venv = venv_name
							config.settings.python.venvPath = venv_parent
						end
					end,
				},
				ts_ls = {
					settings = {
						typescript = {
							tsserver = {
								maxTsServerMemory = 8192,
							},
						},
					},
				},
				ruff = {
					cmd_env = { RUFF_TRACE = "messages" },
					root_markers = {
						{
							"pyproject.toml",
							"ruff.toml",
							".ruff.toml",
							".venv",
							"venv",
						},
						".git",
					},
					init_options = {
						settings = {
							logLevel = "error",
						},
					},
					before_init = function(_, config)
						local _, venv_dir = find_python_venv(config.root_dir)
						if venv_dir then
							config.cmd_env = config.cmd_env or {}
							config.cmd_env.VIRTUAL_ENV = venv_dir
						end
					end,
				},
				prismals = {},
				dockerls = {},
				docker_compose_language_service = {},
				jsonls = {
					before_init = function(_, new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
						json = {
							format = {
								enable = true,
							},
							validate = { enable = true },
						},
					},
				},
				marksman = {},
				tailwindcss = {
					filetypes_exclude = { "markdown" },
					filetypes_include = {},
					settings = {
						tailwindCSS = {
							includeLanguages = {
								elixir = "html-eex",
								eelixir = "html-eex",
								heex = "html-eex",
							},
						},
					},
				},
			}

			-- Handle tailwindcss filetypes: start from defaults, remove excluded, add included
			local tailwind_config = server_configs.tailwindcss
			local tailwind_defaults = vim.lsp.config.tailwindcss
			if tailwind_defaults then
				tailwind_config.filetypes = vim.tbl_filter(function(ft)
					return not vim.tbl_contains(tailwind_config.filetypes_exclude or {}, ft)
				end, tailwind_defaults.filetypes or {})
				vim.list_extend(tailwind_config.filetypes, tailwind_config.filetypes_include or {})
			end
			tailwind_config.filetypes_exclude = nil
			tailwind_config.filetypes_include = nil

			-- Define configs using the new Neovim 0.11+ LSP API
			for server, config in pairs(server_configs) do
				config.capabilities = capabilities
				vim.lsp.config[server] = config
			end

		end,
	},
}
