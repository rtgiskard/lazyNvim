local option = require('init.options')
local keymap = require('init.keymaps')

return {
	-- lspconfig
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		keys = keymap.lsp,
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = '●' },
				severity_sort = true,
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { 'vim' },
							},
						},
					},
				},
				clangd = {
					filetypes = { 'c', 'cpp' },
				},
				biome = { -- https://biomejs.dev/guides/integrate-in-editor/
					workspace_required = false,
				},
			},
		},
		config = function(_, opts)
			-- diagnostic
			vim.diagnostic.config(opts.diagnostics)

			-- apply customized lsp config
			for server, conf in pairs(opts.servers) do
				vim.lsp.config(server, conf)
			end
		end,
		dependencies = {
			-- lsp server setup
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			-- lsp completion
			'saghen/blink.cmp',
		},
	},

	-- easy lspconfig: implicitly load mason and auto install lsp servers
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = true,
		opts = {
			ensure_installed = option.plugins.lsp_servers,
			automatic_installation = false,
		},
		dependencies = {
			'williamboman/mason.nvim',
			-- 'neovim/nvim-lspconfig',
		},
	},

	-- manage LSP servers, DAP servers, linters, and formatters
	{
		'williamboman/mason.nvim',
		cmd = 'Mason',
		build = ':MasonUpdate',
		opts = { -- required for :Mason
			log_level = vim.log.levels.OFF,
			max_concurrent_installers = 4,
			ui = {
				-- disable check on :Mason window
				check_outdated_packages_on_open = false,

				border = 'rounded',
				width = 0.8,
				height = 0.8,
			},
		},
	},

	-- lightweight yet powerful formatter
	{
		'stevearc/conform.nvim',
		lazy = true,
		opts = function()
			return vim.tbl_deep_extend('keep', option.plugins.conform_opts, {
				notify_on_error = true,
				log_level = vim.log.levels.OFF,
			})
		end,
	},

	-- asynchronous linter, beyond lsp
	{
		'mfussenegger/nvim-lint',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = function()
			return vim.tbl_deep_extend('keep', option.plugins.linter_opts, {
				-- some linters may rely on files to be saved
				trigger_on_events = {
					'BufWritePost',
					'BufReadPost',
					'InsertLeave',
					'TextChanged',
				},
			})
		end,
		config = function(_, opts)
			local lint = require('lint')

			-- bind linters
			for name, linter in pairs(opts.linters) do
				if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
					lint.linters[name] =
						vim.tbl_deep_extend('force', lint.linters[name], linter)
				else
					lint.linters[name] = linter
				end
			end

			lint.linters_by_ft = opts.linters_by_ft

			-- trigger lint
			vim.api.nvim_create_autocmd(opts.trigger_on_events, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	-- better diagnostics list and others
	{
		'folke/trouble.nvim',
		cmd = 'Trouble',
		opts = {},
		keys = keymap.trouble,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			'neovim/nvim-lspconfig',
		},
	},
}
