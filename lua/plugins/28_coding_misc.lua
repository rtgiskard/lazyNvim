local keymap = require('init.keymaps')

return {
	-- completion
	{
		'saghen/blink.cmp',
		event = 'InsertEnter',
		-- use prebuilt binary for fuzzy
		-- version = '1.*',
		-- build = 'cargo build --release',
		opts = {
			keymap = keymap.cmp,
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 400,
					window = { border = 'rounded' },
				},
				list = { selection = { preselect = true, auto_insert = false } },
				menu = { border = 'rounded', draw = { treesitter = { 'lsp' } } },
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
				providers = {
					lsp = { score_offset = 4 },
					buffer = { score_offset = 2 },
					path = { score_offset = 2 },
					snippets = { score_offset = -2, min_keyword_length = 2 },
				},
			},
			snippets = { preset = 'luasnip' },
			signature = {
				enabled = false,
				window = { show_documentation = false, border = 'rounded' },
			},
			cmdline = { enabled = false },
			fuzzy = {
				implementation = 'lua',
				sorts = {
					'score',
					'sort_text',
				},
			},
		},
		dependencies = {
			'L3MON4D3/LuaSnip',
		},
	},

	-- snippet engine, for friendly-snippets
	{
		'L3MON4D3/LuaSnip',
		event = 'VeryLazy',
		version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		build = 'make install_jsregexp',
		config = function()
			require('luasnip.loaders.from_vscode').lazy_load()
		end,
		dependencies = { 'rafamadriz/friendly-snippets' },
	},

	-- comments
	{
		'echasnovski/mini.comment',
		event = 'VeryLazy',
		opts = { mappings = keymap.mini_comment },
	},

	-- todo comments
	{
		'folke/todo-comments.nvim',
		cmd = { 'TodoTrouble' },
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {},
		dependencies = { 'nvim-lua/plenary.nvim' },
	},

	-- d2 diagram
	{
		'terrastruct/d2-vim',
		ft = { 'd2' },
	},

	-- diff view
	{
		'sindrets/diffview.nvim',
		cmd = { 'DiffviewOpen' },
	},

	-- git buffer integration
	{
		'lewis6991/gitsigns.nvim',
		cmd = { 'Gitsigns' },
		opts = {},
	},

	-- csv/tsv
	{
		'hat0uma/csvview.nvim',
		cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
		opts = {
			parser = { comments = { '#', '//' } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { 'if', mode = { 'o', 'x' } },
				textobject_field_outer = { 'af', mode = { 'o', 'x' } },
				-- Excel-like navigation: move with tab and enter
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
				jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
				jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
				jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
			},
		},
	},
}
