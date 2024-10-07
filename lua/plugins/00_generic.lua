local keymap = require('init.keymaps')

return {
	-- the package manager
	{ 'folke/lazy.nvim' },

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

	-- statusline
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		opts = {
			options = {
				globalstatus = false,
				icons_enabled = true,
				theme = 'auto',
				disabled_filetypes = {
					statusline = { 'dashboard', 'alpha' },
				},
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = {
					'branch',
					'diff',
					{ 'diagnostics', sources = { 'nvim_lsp', 'nvim_diagnostic' } },
				},
				lualine_c = {
					'filename',
					{
						function()
							return require('nvim-navic').get_location()
						end,
						cond = function()
							return package.loaded['nvim-navic']
								and require('nvim-navic').is_available()
						end,
					},
				},
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' },
			},
			extensions = { 'neo-tree' },
		},
		dependencies = {
			-- optional
			'nvim-tree/nvim-web-devicons',
		},
	},

	-- indent guides
	{
		'lukas-reineke/indent-blankline.nvim',
		event = { 'BufReadPost', 'BufNewFile' },
		main = 'ibl',
		opts = {
			indent = {
				char = '│',
				tab_char = '│',
			},
			scope = { enabled = false },
			-- stylua: ignore
			exclude = {
				filetypes = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
			},
		},
	},

	-- active indent guide and indent text objects
	{
		'echasnovski/mini.indentscope',
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {
			symbol = '│',
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd('FileType', {
				-- stylua: ignore
				pattern = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- file explorer
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		cmd = 'Neotree',
		keys = keymap.neotree,
		opts = {
			filesystem = {
				use_libuv_file_watcher = true,
			},
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',

			-- optional
			'nvim-tree/nvim-web-devicons',
		},
	},

	-- fuzzy finder
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		keys = keymap.telescope,
		opts = {
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		},
		dependencies = {
			'nvim-lua/plenary.nvim',

			-- optional
			'nvim-treesitter/nvim-treesitter',
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

	-- measure startuptime
	{
		'dstein64/vim-startuptime',
		cmd = 'StartupTime',
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

	-- make editing big files faster
	{
		'LunarVim/bigfile.nvim',
		opts = {
			filesize = 4, -- size of the file in MiB, the plugin round file sizes to the closest MiB
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
