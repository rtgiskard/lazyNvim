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

	-- bufferline
	{
		'akinsho/bufferline.nvim',
		event = 'VeryLazy',
		keys = keymap.bufferline,
		opts = {
			options = {
				diagnostics = 'nvim_lsp',
				always_show_bufferline = false,
				offsets = {
					{
						filetype = 'neo-tree',
						text = 'Neo-tree',
						highlight = 'Directory',
						text_align = 'left',
					},
				},
			},
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
		opts = {
			char = '│',
			-- stylua: ignore
			filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
			show_trailing_blankline_indent = false,
			show_current_context = false,
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
		config = function(_, opts)
			require('mini.indentscope').setup(opts)
		end,
	},

	-- file explorer
	{
		'nvim-neo-tree/neo-tree.nvim',
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
		dependencies = {
			'nvim-lua/plenary.nvim',

			-- optional
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		},
	},

	-- search/replace in multiple files
	{
		'windwp/nvim-spectre',
		lazy = true,
		keys = keymap.spectre,
	},

	-- minimal and fast autopairs
	{
		'echasnovski/mini.pairs',
		event = 'VeryLazy',
		opts = {
			modes = { insert = true, command = false, terminal = false },
		},
		config = function(_, opts)
			require('mini.pairs').setup(opts)
		end,
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
}
