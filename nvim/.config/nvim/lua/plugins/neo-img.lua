return {
	{
		"skardyy/neo-img",
		build = ":NeoImg Install",
		config = function()
			local ttyimg_bin = vim.fn.stdpath("data") .. "/lazy/neo-img/ttyimg/ttyimg"
			if vim.fn.filereadable(ttyimg_bin) == 1 and vim.fn.executable(ttyimg_bin) == 0 then
				vim.fn.setfperm(ttyimg_bin, "rwxr-xr-x")
			end
			require("neo-img").setup()
		end,
	},
}
