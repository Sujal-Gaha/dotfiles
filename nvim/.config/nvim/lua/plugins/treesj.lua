return {
	{
		"wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{ "<leader>j", "<cmd>TSJToggle<cr>", desc = "Toggle Split/Join" },
			{ "<leader>js", "<cmd>TSJSplit<cr>", desc = "Split" },
			{ "<leader>jj", "<cmd>TSJJoin<cr>", desc = "Join" },
		},
		opts = {
			use_default_keymaps = false,
			check_syntax_error = true,
			max_join_length = 120,
			cursor_behavior = "hold", -- "hold" | "start" | "end"
			notify = true,
			dot_repeat = true,
			on_error = nil,

			-- Language-specific settings
			langs = {
				python = {
					-- Custom split/join for Python
					list = { both = { recursive = true } },
					dict = { both = { recursive = true } },
				},
				javascript = {
					object = { both = { recursive = true } },
					array = { both = { recursive = true } },
				},
				typescript = {
					object = { both = { recursive = true } },
					array = { both = { recursive = true } },
				},
				lua = {
					table = { both = { recursive = true } },
				},
			},
		},
	},
}
