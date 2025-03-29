local keymap = require('init.keymaps')

return {
	-- auto completion
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		opts = function()
			local cmp = require('cmp')

			return {
				completion = {
					completeopt = 'menu,menuone,noinsert',
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = 'path' },
					{ name = 'buffer' },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}),
				mapping = keymap.cmp_mapping(cmp),
			}
		end,
		dependencies = {
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp', -- may need lsp to works
			'saadparwaiz1/cmp_luasnip', -- load LuaSnip if exist
		},
	},

	-- snippets
	{
		'L3MON4D3/LuaSnip',
		event = 'InsertEnter',
		build = 'make install_jsregexp',
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
