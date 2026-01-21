-- Basic editor settings
vim.opt.number = true -- Show current line number
vim.opt.relativenumber = true -- Show relative line numbers (great for motions like 5j)
vim.opt.mouse = "a" -- Enable mouse in all modes (useful in terminal)
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard (+ register)
vim.opt.breakindent = true -- Indent wrapped lines
vim.opt.undofile = true -- Persistent undo across sessions
vim.opt.ignorecase = true -- Case-insensitive search...
vim.opt.smartcase = true -- ...unless uppercase is used
vim.opt.updatetime = 250 -- Faster completion and CursorHold events
vim.opt.timeoutlen = 300 -- Shorter leader key timeout
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.scrolloff = 12 -- Keep 12 lines visible above/below cursor
vim.opt.sidescrolloff = 12 -- Same for horizontal
vim.opt.inccommand = "split" -- Live preview for :s/// commands

vim.opt.confirm = true

-- Better indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- 2 spaces for indent
vim.opt.tabstop = 2 -- 2 spaces for tabs
vim.opt.smartindent = true

-- Set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use the terminal's background color (critical for Kitty transparency)
vim.opt.background = "dark" -- Or "light" if your Kitty is light-themed

-- Clear any explicit background highlight (ensures transparency works)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- For floating windows (e.g., LSP hover)

-- Kitty-specific fix for background erase issues
vim.opt.termguicolors = true -- Enable true colors (usually already on)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins") -- This loads plugins from lua/plugins/

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		local opts = { buffer = ev.buf, silent = true }

		-- Common keymaps for all LSP servers
		-- Navigation (using Telescope)
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

		-- Info
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts) -- Changed from <C-k> to avoid conflict

		-- Refactor
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		-- Diagnostics
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

		-- Disable formatting for all servers (use conform.nvim or similar)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		-- Server-specific configurations
		if client.name == "ruff" or client.name == "ruff_lsp" then
			-- Disable hover for ruff (let pyright handle it)
			client.server_capabilities.hoverProvider = false

			-- Organize imports for Python
			vim.keymap.set("n", "<leader>co", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.organizeImports" } },
					apply = true,
				})
			end, { buffer = ev.buf, desc = "Organize Imports" })
		end

		if client.name == "vtsls" then
			-- Organize imports for TypeScript/JavaScript
			vim.keymap.set("n", "<leader>co", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.organizeImports" } },
					apply = true,
				})
			end, { buffer = ev.buf, desc = "Organize Imports" })

			-- Add missing imports
			vim.keymap.set("n", "<leader>cM", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.addMissingImports.ts" } },
					apply = true,
				})
			end, { buffer = ev.buf, desc = "Add missing imports" })

			-- Remove unused imports
			vim.keymap.set("n", "<leader>cu", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.removeUnused.ts" } },
					apply = true,
				})
			end, { buffer = ev.buf, desc = "Remove unused imports" })

			-- Fix all diagnostics
			vim.keymap.set("n", "<leader>cD", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.fixAll.ts" } },
					apply = true,
				})
			end, { buffer = ev.buf, desc = "Fix all diagnostics" })
		end
	end,
})
