-- Force folding settings on every file open
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost", "BufNewFile" }, {
	pattern = "*",
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt_local.foldlevel = 99
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.colorProvider = false
		end
	end,
})
