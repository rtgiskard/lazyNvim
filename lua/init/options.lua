local M = {}

-- vim.opt: :set
M.opt_o = {
	autowrite = false,
	confirm = true, -- confirm to save changes before exit
	cursorline = true, -- highlight cursorline
	wrap = false,

	expandtab = false,
	tabstop = 4,
	softtabstop = 0,
	shiftwidth = 0,
	laststatus = 1,

	background = 'dark',
	termguicolors = true,

	modeline = true,
	modelines = 2,

	list = true,
	listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←',

	foldmethod = 'expr',
	foldexpr = 'nvim_treesitter#foldexpr()',
	foldenable = false,

	grepprg = 'rg --vimgrep',
	grepformat = '%f:%l:%c:%m',

	-- wait to match keymap in ms
	timeout = true,
	timeoutlen = 500,

	-- dev related
	signcolumn = 'yes', -- always show to avoid text shift
	number = false,
	relativenumber = false,
	mouse = '',
}

-- vim.g: :setglobal
M.opt_g = {
	mapleader = ',',

	-- split gdb and source code window vertical
	termdebug_wide = '1',
}

-- to be used by lazy
M.plugins = {
	-- lazy.nvim
	auto_install = true, -- this should be true on bootsrap, and then can be set to false
	auto_check = false, -- disable automatically check of updates in background

	-- colorscheme plugin to load
	colorscheme = 'tokyonight',

	-- stylua: ignore
	ts_parsers = {
		'c', 'cpp', 'go', 'python', 'lua', 'vala', 'bash',
		'meson', 'make', 'dockerfile', 'toml', 'yaml',
		'vim', 'vimdoc', 'query', 'regex', 'latex',
		'markdown', 'markdown_inline',
	},

	lsp_servers = {
		'clangd',
		'gopls',
		-- 'pylyzer',
		'pyright',
		'lua_ls',
		'vala_ls',
		'rust_analyzer',
	},

	-- null-ls sources: formatter and linter
	nls_sources = function(nls)
		return {
			-- formatter
			nls.builtins.formatting.clang_format,
			nls.builtins.formatting.gofmt,
			nls.builtins.formatting.rustfmt,
			nls.builtins.formatting.yapf,
			nls.builtins.formatting.stylua,
			nls.builtins.formatting.shfmt,

			-- linter
			nls.builtins.diagnostics.clang_check,
			nls.builtins.diagnostics.ruff,
		}
	end,

	-- lsp format timeout
	fmt_timeout_ms = 4000,
}

-- stylua: ignore
function M.load_options()
	for k, v in pairs(M.opt_o) do vim.o[k] = v end
	for k, v in pairs(M.opt_g) do vim.g[k] = v end
end

return M
