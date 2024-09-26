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
	listchars = 'tab:▸·,nbsp:+,trail:·,extends:→,precedes:←',

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

	-- header for dashboard
	header = nil,

	-- stylua: ignore
	ts_parsers = {
		'c', 'cpp', 'zig', 'go', 'python', 'lua', 'vala', 'bash',
		'meson', 'make', 'cmake', 'dockerfile',
		'toml', 'yaml', 'proto', 'sql', 'scheme',
		'vim', 'vimdoc', 'query', 'regex', 'latex',
		'markdown', 'markdown_inline',
	},

	lsp_servers = {
		'clangd',
		'zls',
		'gopls',
		-- 'pylyzer',
		'pyright',
		'lua_ls',
		'vala_ls',
		'rust_analyzer',
		'biome', -- ft: json, javascript, typescript
	},

	-- linter: nvim-lint
	linter_opts = {
		-- lint only the listed ft
		linters_by_ft = {
			python = { 'ruff' },
		},

		-- customize linters
		linters = {},
	},

	-- formatter: conform
	conform_opts = {
		-- format only the listed ft
		formatters_by_ft = {
			zig = { 'zigfmt' },
			python = { 'ruff_format' },
			rust = { 'rustfmt' },
			vala = { 'uncrustify' },
			lua = { 'stylua' },
			sh = { 'shfmt' },

			d2 = { 'd2' },

			-- Use a sub-list to run only the first available formatter
			css = { { 'prettierd', 'prettier' } },
			scss = { { 'prettierd', 'prettier' } },
		},

		-- customize formatters
		formatters = {
			uncrustify = {
				env = { UNCRUSTIFY_CONFIG = '.uncrustify.cfg' },
			},
		},

		default_format_opts = {
			lsp_format = 'fallback',
			quiet = true,

			-- nvim lsp
			async = true, -- edit during format can lead to unexpected changes for lsp format
			timeout_ms = 2000, -- ignored if async=true
		},

		-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
	},
}

-- stylua: ignore
function M.load_options()
	for k, v in pairs(M.opt_o) do vim.o[k] = v end
	for k, v in pairs(M.opt_g) do vim.g[k] = v end

	-- disable lsp log, which can be large
	vim.lsp.set_log_level('off')
end

return M
