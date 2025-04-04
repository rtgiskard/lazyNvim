local keymap = require('init.keymaps')

return {
	-- the package manager
	{ 'folke/lazy.nvim' },

	-- statusline
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		opts = {
			options = {
				theme = 'auto',
				globalstatus = false,
				icons_enabled = true,
				disabled_filetypes = {
					statusline = { 'dashboard', 'alpha' },
				},
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename', 'searchcount' },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' },
			},
		},
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

	-- session management
	{
		'folke/persistence.nvim',
		lazy = true,
		keys = keymap.persistence,
		opts = {
			options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help' },
			pre_save = nil,
		},
		config = function(_, opts)
			-- setup config only, no auto save
			require('persistence.config').setup(opts)
		end,
	},

	-- hint with which-key
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			plugins = { spelling = true },
		},
	},

	-- trim whitespace
	{
		'cappyzawa/trim.nvim',
		cmd = 'Trim',
		keys = keymap.trim,
		opts = {
			trim_on_write = false,
			trim_first_line = false,
		},
	},
}
