return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			{ "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				preselect = cmp.PreselectMode.Item,
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				mapping = {
					["<C-j>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item()
						else
							cmp.complete()
						end
					end, { "i", "s" }),

					["<C-k>"] = cmp.mapping.select_prev_item(),

					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<Esc>"] = cmp.mapping.abort(),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				formatting = {
					format = function(entry, item)
						-- Optional: Add icons first (if you have lspkind)
						-- item = lspkind.cmp_format()(entry, item)

						-- Add tailwindcss colorizer formatting
						return require("tailwindcss-colorizer-cmp").formatter(entry, item)
					end,
				},
			})
		end,
	},
}
