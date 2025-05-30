local keymap = require('init.keymaps')

return {
	-- the package manager
	{ 'folke/lazy.nvim' },

	-- statusline
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		opts = function()
			local symbols = require('trouble').statusline({
				mode = 'lsp_document_symbols',
				groups = {},
				title = false,
				filter = { range = true },
				format = '{kind_icon}{symbol.name:Normal}',
				hl_group = 'lualine_c_normal',
			})

			return {
				options = {
					theme = 'auto',
					globalstatus = false,
					icons_enabled = true,
					disabled_filetypes = {
						statusline = { 'snacks_dashboard' },
					},
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = {
						'filename',
						{ symbols.get, cond = symbols.has },
					},
					lualine_x = { 'encoding', 'fileformat', 'filetype' },
					lualine_y = { 'progress' },
					lualine_z = { 'location' },
				},
				extensions = { 'trouble' },
			}
		end,
		dependencies = {
			-- optional
			'nvim-tree/nvim-web-devicons',
		},
	},

	-- minimal and fast autopairs
	{
		'echasnovski/mini.pairs',
		event = 'VeryLazy',
		opts = {
			modes = { insert = true, command = false, terminal = false },
		},
	},

	-- session management
	{
		'folke/persistence.nvim',
		lazy = true,
		keys = keymap.persistence,
		opts = {
			options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help' },
			pre_save = nil,
		},
		config = function(_, opts)
			-- setup config only, no auto save
			require('persistence.config').setup(opts)
		end,
	},

	-- hint with which-key
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			plugins = { spelling = true },
		},
	},

	-- trim whitespace
	{
		'cappyzawa/trim.nvim',
		cmd = 'Trim',
		keys = keymap.trim,
		opts = {
			trim_on_write = false,
			trim_first_line = false,
		},
	},

	-- make editing big files faster
	{
		'LunarVim/bigfile.nvim',
		opts = {
			filesize = 4, -- size of the file in MiB, round to the closest MiB
			pattern = { '*' }, -- autocmd pattern or function
			features = { -- features to disable
				'lsp',
				'treesitter',
				'syntax',
				'matchparen',
				'vimopts',
				'filetype',
				'indent_blankline',
			},
		},
	},
}
