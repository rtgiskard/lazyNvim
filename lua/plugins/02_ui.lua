local keymap = require('init.keymaps')

return {
	-- better `vim.notify()`
	{
		'rcarriga/nvim-notify',
		keys = keymap.notify,
		opts = {
			timeout = 4000,
			background_colour = '#000000',
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},

	-- noice ui, customize views
	{
		'rtgiskard/noice.nvim',
		branch = 'dev',
		event = 'VeryLazy',
		opts = {
			cmdline = {
				enabled = true,
				view = 'cmdline',
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
				},
			},
		},
		dependencies = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
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
				statuscolumn = { enabled = true },
				scope = { enabled = false },
				scroll = { enabled = false },
				words = { enabled = false },
			}
		end,
	},

	-- icons
	{ 'nvim-tree/nvim-web-devicons', lazy = true },

	-- UI Component Library
	{ 'MunifTanjim/nui.nvim', lazy = true },
}
