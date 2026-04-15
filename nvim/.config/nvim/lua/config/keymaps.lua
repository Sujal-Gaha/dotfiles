-- This file is for general keymaps and LSP-specific mappings
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		-- Navigation
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

		-- Info
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts)

		-- Refactor
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		-- Diagnostics
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

		-- Formatting handled by conform.nvim
		client.server_capabilities.documentFormattingProvider = false

		-- Language Specific Organizers
		if client.name == "ruff" or client.name == "ruff_lsp" then
			client.server_capabilities.hoverProvider = false
			vim.keymap.set("n", "<leader>co", function()
				vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
			end, { buffer = ev.buf, desc = "Organize Imports" })
		end

		-- Add vtsls logic here as well...
	end,
})
