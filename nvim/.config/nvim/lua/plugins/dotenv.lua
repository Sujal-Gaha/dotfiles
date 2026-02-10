return {
	{
		"ellisonleao/dotenv.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("dotenv").setup({
				enable_on_load = true, -- auto-load .env on startup
				verbose = false, -- no spam
			})
		end,
	},
}
