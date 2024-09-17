return {
	-- python virtual environment
	{
		'linux-cultist/venv-selector.nvim',
		cmd = { 'VenvSelect', 'VenvSelectCached' },
		lazy = true,
		branch = 'regexp',
		config = function()
			require('venv-selector').setup()
		end,
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-telescope/telescope.nvim',
			-- 'mfussenegger/nvim-dap-python',
		},
	},
}
