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

			local server_configs = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				pyright = {},
				ts_ls = {},
				ruff = {
					cmd_env = { RUFF_TRACE = "messages" },
					init_options = {
						settings = {
							logLevel = "error",
						},
					},
				},
				ruff_lsp = {
					cmd_env = { RUFF_TRACE = "messages" },

					init_options = {
						settings = {
							logLevel = "error",
						},
					},
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

			-- Special setup for tailwindcss filetypes
			local tailwind_config = server_configs.tailwindcss
			tailwind_config.filetypes = tailwind_config.filetypes or {}

			-- Add default filetypes
			vim.list_extend(tailwind_config.filetypes, vim.lsp.config.tailwindcss.filetypes or {})

			-- Remove excluded filetypes
			tailwind_config.filetypes = vim.tbl_filter(function(ft)
				return not vim.tbl_contains(tailwind_config.filetypes_exclude or {}, ft)
			end, tailwind_config.filetypes)

			-- Add additional filetypes
			vim.list_extend(tailwind_config.filetypes, tailwind_config.filetypes_include or {})

			-- Define configs using the new Neovim LSP API
			for server, config in pairs(server_configs) do
				config.capabilities = capabilities
				vim.lsp.config[server] = config
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false

						if client.name == "ruff" then
							client.server_capabilities.hoverProvider = false
						end
					end
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if client and (client.name == "ruff" or client.name == "ruff_lsp") then
						vim.keymap.set("n", "<leader>co", function()
							vim.lsp.buf.code_action({
								context = {
									only = { "source.organizeImports" },
								},
								apply = true,
							})
						end, { buffer = ev.buf, desc = "Organize Imports" })
					end
				end,
			})
		end,
	},
}
