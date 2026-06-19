return {
	-- the package manager
	{ 'folke/lazy.nvim' },

	-- statusline
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		opts = function()
			return {
				options = {
					theme = 'auto',
					globalstatus = false,
					icons_enabled = true,
					disabled_filetypes = {
						statusline = { 'snacks_dashboard' },
					},
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { 'filename' },
					lualine_x = { 'encoding', 'fileformat', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' },
				},
			}
		end,
		dependencies = {
			-- optional
			'nvim-tree/nvim-web-devicons',
		},
	},

	-- minimal and fast autopairs
	{
		'echasnovski/mini.pairs',
		event = 'VeryLazy',
		opts = {
			modes = { insert = true, command = false, terminal = false },
		},
	},

	-- hint with which-key
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			plugins = { spelling = true },
		},
	},
}
