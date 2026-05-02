return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			-- Tell LuaSnip to load snippets from your new directory
			require("luasnip.loaders.from_lua").load({
				paths = { vim.fn.stdpath("config") .. "/lua/config/snippets" },
			})

			-- Your existing keymaps remain exactly the same
			vim.keymap.set({ "i", "s" }, "<Tab>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })
		end,
	},
}
