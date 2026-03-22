return {
	{
		"LazyVim/LazyVim",
		opts = { colorscheme = "base16-matugen" },
	},
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			local colors_file = vim.fn.stdpath("config") .. "/colors/base16-matugen.vim"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(colors_file, {}, vim.schedule_wrap(function()
					vim.cmd("source " .. colors_file)
					print("Theme reloaded")
				end))
			end
		end,
	},
}
