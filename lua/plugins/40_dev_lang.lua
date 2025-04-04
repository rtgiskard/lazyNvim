return {
	-- python virtual environment
	{
		'linux-cultist/venv-selector.nvim',
		cmd = { 'VenvSelect', 'VenvSelectCached' },
		branch = 'regexp',
		config = function()
			require('venv-selector').setup()
		end,
		dependencies = {
			'neovim/nvim-lspconfig',
			-- 'mfussenegger/nvim-dap-python',
		},
	},
}
