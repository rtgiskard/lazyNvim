return {
	-- python virtual environment
	{
		'linux-cultist/venv-selector.nvim',
		cmd = { 'VenvSelect', 'VenvSelectCached' },
		lazy = true,
		opts = function()
			local util = require('init.utils')

			return {
				dap_enabled = util.has('nvim-dap-python'),
				auto_refresh = false,
				search = false,
				search_venv_managers = true,
				search_workspace = true,
			}
		end,
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-telescope/telescope.nvim',
			-- 'mfussenegger/nvim-dap-python',
		},
	},
}
