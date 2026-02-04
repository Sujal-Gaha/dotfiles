return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- For nice icons (requires Nerd Font)
		config = function()
			require("nvim-tree").setup({
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30, -- Sidebar width
					side = "left",
				},
				renderer = {
					group_empty = true, -- Collapse empty folders
					icons = {
						show = {
							git = true,
							folder = true,
							file = true,
						},
					},
				},
				filters = {
					dotfiles = false, -- Show hidden files? Toggle with H
				},
				git = {
					enable = true,
					ignore = false, -- Show git-ignored files
				},
				filesystem_watchers = {
					ignore_dirs = {
						"chroma_data",
					},
				},
			})
		end,
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
			{ "<leader>o", "<cmd>NvimTreeFindFile<cr>", desc = "Focus Current File in Explorer" },
		},
	},
}
