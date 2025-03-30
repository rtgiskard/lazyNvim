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

	-- icons
	{ 'nvim-tree/nvim-web-devicons', lazy = true },

	-- UI Component Library
	{ 'MunifTanjim/nui.nvim', lazy = true },
}
