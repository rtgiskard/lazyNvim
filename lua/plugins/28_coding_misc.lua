local keymap = require('init.keymaps')

return {
	-- debug adapter protocol client
	{
		'mfussenegger/nvim-dap',
		lazy = true,
	},

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

	-- snippets: not configured yet
	{ 'L3MON4D3/LuaSnip', lazy = true },

	-- comments
	{
		'echasnovski/mini.comment',
		event = 'VeryLazy',
		opts = {
			mappings = keymap.mini_comment,
			hooks = {
				pre = function()
					require('ts_context_commentstring.internal').update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require('mini.comment').setup(opts)
		end,
		dependencies = {
			'JoosepAlviste/nvim-ts-context-commentstring',
		},
	},

	-- todo comments
	{
		'folke/todo-comments.nvim',
		cmd = { 'TodoTrouble', 'TodoTelescope' },
		event = { 'BufReadPost', 'BufNewFile' },
		keys = keymap.todo_comments,
		config = true,
	},

	-- codeium ai as complete source for cmp
	{
		'jcdickinson/codeium.nvim',
		lazy = true,
		cmd = 'Codeium',
		opts = {},
		config = function(_, opts)
			vim.notify('codeium loaded ..', vim.log.levels.INFO)
			require('codeium').setup(opts)
		end,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'hrsh7th/nvim-cmp',
		},
	},
}
