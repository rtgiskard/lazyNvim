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

			local layouts = {
				m_picker = {
					reverse = true,
					cycle = true,
					layout = {
						box = 'horizontal',
						backdrop = false,
						width = 0.78,
						height = 0.87,
						{
							box = 'vertical',
							border = 'rounded',
							title = '{title} {live} {flags}',
							{ win = 'list', border = 'none' },
							{ win = 'input', height = 1, border = 'top' },
							width = 0.43,
						},
						{
							win = 'preview',
							title = '{preview}',
							border = 'rounded',
						},
					},
				},
				m_sidebar = {
					preview = 'main',
					layout = {
						backdrop = false,
						width = 40,
						min_width = 40,
						height = 0,
						position = 'left',
						border = 'none',
						box = 'vertical',
						{ win = 'list', border = 'none' },
						{
							win = 'preview',
							title = '{preview}',
							height = 0.4,
							border = 'top',
						},
						{
							win = 'input',
							height = 1,
							border = 'top',
							title = '{title} {live} {flags}',
							title_pos = 'center',
						},
					},
				},
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
					sources = {
						explorer = {
							layout = { preset = 'm_sidebar', preview = false },
						},
						lsp_symbols = {
							icons = { tree = { last = '┌╴' } },
						},
					},
					layout = { cycle = true, preset = 'm_picker' },
					layouts = layouts,
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
