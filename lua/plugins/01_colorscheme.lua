return {
	-- colortheme is load right after lazy setup

	-- tokyonight
	{
		'folke/tokyonight.nvim',

		lazy = true,
		priority = 1000,

		opts = {
			style = 'night',
			transparent = true,
			on_colors = function(colors)
				colors.bg_highlight = '#161728'
			end,
		},
	},

	-- nightfly
	{
		'bluz71/vim-nightfly-colors',
		name = 'nightfly',

		lazy = true,
		priority = 1000,
	},
}
