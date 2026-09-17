-- 1. General keymaps
-- These are always active
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "Y", "yy")

-- 2. LSP-Specific Mappings & Client Configurations
-- Consolidated into a single augroup with clean deduplication
local lsp_attach_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_attach_group,
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		-- Formatting is handled by conform.nvim
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		client.server_capabilities.colorProvider = false

		-- Ruff hover disabled in favor of Pyright
		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end

		-- Navigation
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to Declaration" }))
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Go to References" }))

		-- Info
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
		vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature Help" }))

		-- Refactor
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }))

		-- Diagnostics
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
		vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show Line Diagnostics" }))

		-- Language Specific Organizers
		if vim.tbl_contains({ "ruff", "ts_ls", "vtsls", "gopls" }, client.name) then
			vim.keymap.set("n", "<leader>co", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.organizeImports" } },
					apply = true,
				})
			end, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
		end
	end,
})
