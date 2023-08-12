local option = require('init.options')
local keymap = require('init.keymaps')

return {
	-- language parser
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {
			auto_install = false,
			ensure_installed = option.plugins.ts_parsers,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		},
		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
		end,
		dependencies = {
			-- auto load
			'nvim-treesitter/nvim-treesitter-refactor',
			'HiPhish/rainbow-delimiters.nvim',
		},
	},

	-- ts refactor module
	{
		'nvim-treesitter/nvim-treesitter-refactor',
		lazy = true,
		config = function()
			require('nvim-treesitter.configs').setup({
				refactor = {
					highlight_definitions = { enable = true },
					highlight_current_scope = { enable = true },
					navigation = {
						enable = true,
						keymaps = keymap.ts_refactor.navigate,
					},
					smart_rename = {
						enable = true,
						keymaps = keymap.ts_refactor.rename,
					},
				},
			})
		end,
	},

	-- rainbow parentheses with ts
	{
		'HiPhish/rainbow-delimiters.nvim',
		lazy = true,
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
