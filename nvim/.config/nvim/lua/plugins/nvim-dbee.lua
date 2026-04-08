return {
	{
		"kndndrj/nvim-dbee",
		dependencies = { "MunifTanjim/nui.nvim" },
		build = function()
			require("dbee").install("go") -- installs Go binary if needed
		end,
		config = function()
			-- Pull values from environment variables (set in your shell / .env)
			local mysql_user = os.getenv("MYSQL_USER") or "user"
			local mysql_password = os.getenv("MYSQL_PASSWORD") or "password"
			local mysql_db = os.getenv("MYSQL_DATABASE") or "mydb"
			local mysql_root_password = os.getenv("MYSQL_ROOT_PASSWORD") or "root"

			local postgres_user = os.getenv("POSTGRES_USER") or "user"
			local postgres_password = os.getenv("POSTGRES_PASSWORD") or "password"
			local postgres_db = os.getenv("POSTGRES_DB") or "mydb"

			require("dbee").setup({
				sources = {
					require("dbee.sources").MemorySource:new({
						{
							id = "1",
							name = "MySQL",
							type = "mysql",
							url = string.format("%s:%s@tcp(localhost:3306)/%s", mysql_user, mysql_password, mysql_db),
						},

						{
							id = "2",
							name = "PostgreSQL",
							type = "postgresql",
							url = string.format(
								"postgresql://%s:%s@localhost:5432/%s?sslmode=disable",
								postgres_user,
								postgres_password,
								postgres_db
							),
						},
					}),

					-- Keep UI persistence (saved connections stay local, not in git)
					require("dbee.sources").FileSource:new(vim.fn.stdpath("state") .. "/nvim/dbee/persistence.json"),
				},
				-- layout = "vertical", -- or "horizontal" if preferred
			})
		end,
		keys = {
			{
				"<leader>db",
				function()
					require("dbee").open()
				end,
				desc = "Open DB Explorer (Dbee)",
			},
		},
	},
}
