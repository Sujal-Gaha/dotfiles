return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Optional: Faster sorting with fzf (requires build tools like make/cmake)
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make", -- Or "cmake -S. -Bbuild ..." on Windows
			},
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					layout_strategy = "horizontal",
					layout_config = { horizontal = { preview_width = 0.55 } },
					file_ignore_patterns = {
						".git/",
						".venv/",
						"node_modules",
						"__generated__",
						"dist",
						"__pycache__",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = true,
					},
				},
			})

			-- Load fzf extension if available
			pcall(telescope.load_extension, "fzf")
		end,
		keys = {
			{ "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "Find recently opened files" },
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find all Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		},
	},
}
