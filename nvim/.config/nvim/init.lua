-- Basic editor settings 
vim.opt.number = true         -- Show current line number
vim.opt.relativenumber = true -- Show relative line numbers (great for motions like 5j)
vim.opt.mouse = "a"           -- Enable mouse in all modes (useful in terminal)
vim.opt.clipboard = "unnamedplus"  -- Sync with system clipboard (+ register)
vim.opt.breakindent = true    -- Indent wrapped lines
vim.opt.undofile = true       -- Persistent undo across sessions
vim.opt.ignorecase = true     -- Case-insensitive search...
vim.opt.smartcase = true      -- ...unless uppercase is used
vim.opt.updatetime = 250      -- Faster completion and CursorHold events
vim.opt.timeoutlen = 300      -- Shorter leader key timeout
vim.opt.splitright = true     -- Vertical splits open to the right
vim.opt.splitbelow = true     -- Horizontal splits open below
vim.opt.scrolloff = 8         -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8     -- Same for horizontal
vim.opt.inccommand = "split"  -- Live preview for :s/// commands

-- Better indentation
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 2        -- 2 spaces for indent
vim.opt.tabstop = 2           -- 2 spaces for tabs
vim.opt.smartindent = true

-- Set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use the terminal's background color (critical for Kitty transparency)
vim.opt.background = "dark"  -- Or "light" if your Kitty is light-themed

-- Clear any explicit background highlight (ensures transparency works)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })  -- For floating windows (e.g., LSP hover)

-- Kitty-specific fix for background erase issues
vim.opt.termguicolors = true  -- Enable true colors (usually already on)

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

require("lazy").setup("plugins")  -- This loads plugins from lua/plugins/

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- Info
    vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

    -- Refactor
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

    -- Diagnostics
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
  end,
})

