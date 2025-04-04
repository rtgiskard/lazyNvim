local keymap = require('init.keymaps')

return {
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
				{ icon = '󱏋', key = 's', desc = 'Reload', section = 'session' },
				{ icon = '󰒲', key = 'l', desc = 'Lazy', action = ':Lazy' },
				{ icon = '', key = 'q', desc = 'Quit', action = ':qa' },
			}

			return {
				dashboard = {
					width = 48,
					preset = {
						keys = dashboard_keys,
						header = dashboard_header,
					},
				},
				picker = {
					matcher = {
						fuzzy = false,
						smartcase = true,
						ignorecase = true,
					},
				},
				notifier = {
					timeout = 4000,
					style = 'fancy',
					width = { min = 28, max = 0.4 },
					height = { min = 1, max = 0.6 },
				},
				bigfile = { size = 4 * 1024 * 1024 },
				explorer = { enabled = true },
				indent = { enabled = true },
				input = { enabled = true },
				quickfile = { enabled = true },
				statuscolumn = { enabled = false },
				scope = { enabled = false },
				scroll = { enabled = false },
				words = { enabled = false },
			}
		end,
		keys = keymap.snacks(),
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
		},
	},
}
