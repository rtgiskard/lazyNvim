return {
	-- language parser
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = { 'BufReadPost', 'BufNewFile' },
		dependencies = {
			-- auto load
			'HiPhish/rainbow-delimiters.nvim',
		},
	},

	-- rainbow parentheses with ts
	{
		'HiPhish/rainbow-delimiters.nvim',
		lazy = true,
		submodules = false,
		config = function()
			local rainbow = require('rainbow-delimiters')
			require('rainbow-delimiters.setup')({
				strategy = {
					[''] = rainbow.strategy['global'],
					vim = rainbow.strategy['local'],
				},
				query = {
					[''] = 'rainbow-delimiters',
					lua = 'rainbow-blocks',
				},
				highlight = {
					'RainbowDelimiterRed',
					'RainbowDelimiterYellow',
					'RainbowDelimiterBlue',
					'RainbowDelimiterOrange',
					'RainbowDelimiterGreen',
					'RainbowDelimiterViolet',
					'RainbowDelimiterCyan',
				},
			})
		end,
	},
}
