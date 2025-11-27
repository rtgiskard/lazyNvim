return {
	-- python virtual environment
	{
		'linux-cultist/venv-selector.nvim',
		cmd = { 'VenvSelect' },
		opts = {},
		dependencies = {
			'neovim/nvim-lspconfig',
			-- 'mfussenegger/nvim-dap-python',
		},
	},
}
