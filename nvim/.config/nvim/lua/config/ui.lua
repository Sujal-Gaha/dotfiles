vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Transparency Fixes
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Treesitter Highlighting Links
local highlights = {
	["@keyword"] = "Keyword",
	["@function"] = "Function",
	["@variable"] = "Identifier",
	["@string"] = "String",
	["@type"] = "Type",
	["@constant"] = "Constant",
}

for group, link in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, { link = link })
end
