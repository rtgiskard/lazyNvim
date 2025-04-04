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
				},
				list = { selection = { preselect = true, auto_insert = false } },
				menu = { draw = { treesitter = { 'lsp' } } },
			},
			sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
			snippets = { preset = 'default' },
			signature = { enabled = false, window = { show_documentation = false } },
			cmdline = { enabled = false },
			fuzzy = { implementation = 'lua' },
		},
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
		cmd = { 'TodoTrouble', 'TodoTelescope' },
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {},
		keys = keymap.todo_comments,
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
