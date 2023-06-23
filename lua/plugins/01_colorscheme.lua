return {
	-- NOTE: set the `lazy = false` to enable the color scheme

	-- tokyonight
	{
		'folke/tokyonight.nvim',

		lazy = false,
		priority = 1000,
		-- stylua: ignore
		config = function() vim.cmd.colorscheme('tokyonight-night') end,

		opts = {
			transparent = true,
		},
	},

	-- nightfly
	{
		'bluz71/vim-nightfly-colors',
		name = 'nightfly',

		lazy = true,
		priority = 1000,
		-- stylua: ignore
		config = function() vim.cmd.colorscheme 'nightfly' end,
	},
}
