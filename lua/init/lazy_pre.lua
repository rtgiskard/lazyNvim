local M = {}
local option = require('init.options')

function M.check_load_lazy()
	local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

	if not vim.loop.fs_stat(lazypath) then
		-- stylua: ignore
		local install = vim.fn.confirm(
			'lazy plugin not found, install now?', '&Yes\n&No', 2)

		if install == 1 then
			M.bootstrap_lazy(lazypath)
		end
	end

	if vim.loop.fs_stat(lazypath) then
		vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
		M.load_lazy()
	end
end

function M.bootstrap_lazy(path)
	vim.notify('bootstrap lazy.nvim ..', vim.log.levels.INFO)
	-- stylua: ignore
	vim.fn.system({
		'git', 'clone', '--filter=blob:none', '--branch=stable',
		'https://github.com/folke/lazy.nvim.git', path })
end

function M.load_lazy()
	require('lazy').setup({
		spec = { { import = 'plugins' } },

		-- directory where plugins will be installed
		root = vim.fn.stdpath('data') .. '/lazy',
		lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json',

		defaults = { lazy = false, version = false },
		checker = { enabled = option.plugins.auto_check, frequency = 86400 },
		install = {
			missing = option.plugins.auto_install,
			colorscheme = { option.plugins.colorscheme, 'habamax' },
		},
		ui = {
			wrap = true,
			border = 'rounded',
			size = { width = 0.8, height = 0.8 },
		},
		performance = {
			rtp = {
				-- paths = { '/usr/share/vim/vimfiles' },
				disabled_plugins = {
					'gzip',
					'matchit',
					'matchparent',
					'tohtml',
					'tutor',
					'zipPlugin',
				},
			},
		},
	})

	-- load specified colorscheme
	require(option.plugins.colorscheme).load()
end

return M
