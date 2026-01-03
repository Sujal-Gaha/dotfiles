return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright" },  -- Add more servers here
        -- automatic_installation = true,  -- Optional: auto-install missing servers
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Custom settings for specific servers (e.g., lua_ls)
      local server_configs = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            }
          }
        },
        -- Add custom configs for other servers here if needed, e.g.:
        -- pyright = { ... },
      }

      -- Define configs using the new Neovim LSP API
      for server, config in pairs(server_configs) do
        vim.lsp.config(server, config)
      end

      -- Optional: Define empty/default configs for other servers if you want
      -- vim.lsp.config("pyright", {})  -- Example for pyright with defaults
    end
  }
}
