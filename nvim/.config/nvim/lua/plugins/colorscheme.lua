return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- Make sure this loads first
		config = function()
			-- Configure the theme BEFORE loading it
			require("gruvbox").setup({
				terminal_colors = true,
				transparent_mode = true, -- This handles your Kitty transparency correctly
				contrast = "",

				dim_inactive = false, -- Makes the non-focused split less intense

				strikethrough = true,
			})
			vim.cmd("colorscheme gruvbox")
		end,
	},
}
