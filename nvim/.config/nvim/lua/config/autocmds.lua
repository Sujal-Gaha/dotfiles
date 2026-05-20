-- Force folding settings on every file open
-- Removed global foldmethod="expr" to prevent lag and conflict with nvim-ufo
-- nvim-ufo handles this more efficiently.


vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.colorProvider = false
		end
	end,
})
