return {
	-- python virtual environment
	{
		'linux-cultist/venv-selector.nvim',
		cmd = { 'VenvSelect', 'VenvSelectCached' },
		opts = {},
		dependencies = {
			'neovim/nvim-lspconfig',
			-- 'mfussenegger/nvim-dap-python',
		},
	},
}
