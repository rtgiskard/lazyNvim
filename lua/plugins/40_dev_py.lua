return {
	-- python virtual environment
	{
		'linux-cultist/venv-selector.nvim',
		cmd = 'VenvSelect',
		lazy = true,
		opts = {
			auto_refresh = false,
			dap_enabled = false,
			search = false,
			search_venv_managers = true,
			search_workspace = true,
		},
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-telescope/telescope.nvim',
			-- 'mfussenegger/nvim-dap-python',
		},
	},
}
