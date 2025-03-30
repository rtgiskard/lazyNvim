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
				globalstatus = false,
				icons_enabled = true,
				theme = 'auto',
				disabled_filetypes = {
					statusline = { 'dashboard', 'alpha' },
				},
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = {
					'branch',
					'diff',
					{ 'diagnostics', sources = { 'nvim_lsp', 'nvim_diagnostic' } },
				},
				lualine_c = {
					'filename',
				},
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' },
			},
			extensions = { 'neo-tree' },
		},
		dependencies = {
			-- optional
			'nvim-tree/nvim-web-devicons',
		},
	},

	-- fuzzy finder
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		opts = {
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		},
		dependencies = {
			'nvim-lua/plenary.nvim',

			-- optional
			'nvim-treesitter/nvim-treesitter',
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

	-- collection of small QoL plugins
	{
		'folke/snacks.nvim',
		priority = 1000,
		lazy = false,
		opts = function()
			local name = require('init.options').plugins.header
			local dashboard_header = require('init.headers').getHeader(name)

			local dashboard_keys = {
				{
					icon = '',
					key = 'n',
					desc = 'New file',
					action = ':ene | startinsert',
				},
				{
					icon = '',
					key = 'r',
					desc = 'Recent files',
					action = ":lua Snacks.dashboard.pick('oldfiles')",
				},
				{
					icon = '󰥨',
					key = 'f',
					desc = 'Find file',
					action = ":lua Snacks.dashboard.pick('files')",
				},
				{
					icon = '󰱼',
					key = 'g',
					desc = 'Find text',
					action = ":lua Snacks.dashboard.pick('live_grep')",
				},
				-- stylua: ignore
				{ icon = '', key = 's', desc = 'Restore session', section = 'session' },
				{ icon = '󰒲', key = 'l', desc = 'Lazy', action = ':Lazy' },
				{ icon = '', key = 'q', desc = 'Quit', action = ':qa' },
			}
			return {
				dashboard = {
					width = 48,
					preset = {
						pick = nil,
						keys = dashboard_keys,
						header = dashboard_header,
					},
				},
				bigfile = { size = 4 * 1024 * 1024 },
				explorer = { enabled = true },
				indent = { enabled = true },
				input = { enabled = true },
				picker = { enabled = true },
				notifier = { enabled = true },
				quickfile = { enabled = true },
				statuscolumn = { enabled = false },
				scope = { enabled = false },
				scroll = { enabled = false },
				words = { enabled = false },
			}
		end,
		keys = keymap.snacks(),
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
