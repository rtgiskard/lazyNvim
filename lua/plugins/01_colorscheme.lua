return {
	-- NOTE: set the `lazy = false` to enable the color scheme

	-- tokyonight
	{
		'folke/tokyonight.nvim',

		lazy = false,
		priority = 1000,
		-- stylua: ignore
		config = function() vim.cmd.colorscheme 'tokyonight' end,

		opts = { style = 'night' },
	},

	-- catppuccin
	{
		'catppuccin/nvim',
		name = 'catppuccin',

		lazy = true,
		priority = 1000,
		-- stylua: ignore
		config = function() vim.cmd.colorscheme 'catppuccin' end,

		opts = {
			-- latte, frappe, macchiato, mocha
			flavour = 'mocha',
			background = {
				light = 'latte',
				dark = 'mocha',
			},
		},
	},
}
