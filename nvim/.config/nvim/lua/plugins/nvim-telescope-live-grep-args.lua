return {
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
		keys = {
			{ "<leader>fg", "<cmd>Telescope live_grep_args<cr>", desc = "Live Grep (with args)" },
			{ "<leader>fG", "<cmd>Telescope live_grep_args live_grep_args<cr>", desc = "Live Grep (edit args)" },
		},
	},
}
