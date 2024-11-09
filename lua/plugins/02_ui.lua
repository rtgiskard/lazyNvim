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

	-- dashboard
	{
		'goolord/alpha-nvim',
		event = 'VimEnter',
		opts = function()
			local dashboard = require('alpha.themes.dashboard')

			local name = require('init.options').plugins.header
			dashboard.section.header.val = require('init.headers').getHeader(name)

			-- stylua: ignore
			dashboard.section.buttons.val = {
				dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
				dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
				dashboard.button('f', '󰥨  Find file', ':Telescope find_files <CR>'),
				dashboard.button('g', '󰱼  Find text', ':Telescope live_grep <CR>'),
				dashboard.button('s', '  Restore Session', [[:lua require('persistence').load() <cr>]]),
				dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
				dashboard.button('q', '  Quit', ':qa<CR>'),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = 'AlphaButtons'
				button.opts.hl_shortcut = 'AlphaShortcut'
			end
			dashboard.section.header.opts.hl = 'AlphaHeader'
			dashboard.section.buttons.opts.hl = 'AlphaButtons'
			dashboard.section.footer.opts.hl = 'AlphaFooter'
			dashboard.opts.layout[1].val = 7
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == 'lazy' then
				vim.cmd.close()
				vim.api.nvim_create_autocmd('User', {
					pattern = 'AlphaReady',
					callback = function()
						require('lazy').show()
					end,
				})
			end

			require('alpha').setup(dashboard.opts)

			vim.api.nvim_create_autocmd('User', {
				pattern = 'LazyVimStarted',
				callback = function()
					local stats = require('lazy').stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					-- stylua: ignore
					dashboard.section.footer.val = '⚡ ' .. stats.count .. ' plugins loaded in ' .. ms .. 'ms'
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

	-- better vim.ui
	{
		'stevearc/dressing.nvim',
		event = 'VeryLazy',
		opts = {
			input = { enabled = true },
			select = { enabled = true },
		},
	},

	-- icons
	{ 'nvim-tree/nvim-web-devicons', lazy = true },

	-- UI Component Library
	{ 'MunifTanjim/nui.nvim', lazy = true },
}
