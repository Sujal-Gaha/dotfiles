return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Custom settings for specific servers (e.g., lua_ls)
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
				ruff_lsp = {},
				prismals = {},
				dockerls = {},
				docker_compose_language_service = {},
			}

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
