local util = require('init.utils')
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
			},
		},
		config = function(_, opts)
			-- diagnostic
			vim.diagnostic.config(opts.diagnostics)

			-- setup order: mason -> mason-lspconfig - lsp.server
			local have_mason, mlsp = pcall(require, 'mason-lspconfig')
			local mslp_servers = {}
			if have_mason then
				mslp_servers = vim.tbl_keys(
					require('mason-lspconfig.mappings.server').lspconfig_to_package
				)
			end

			-- get the cmp capabilities with cmp_nvim_lsp
			local have_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
			local capabilities = {}
			if have_cmp then
				capabilities = cmp_lsp.default_capabilities(
					vim.lsp.protocol.make_client_capabilities()
				)
			end

			-- define setup handler for mason-lspconfig
			local function s_setup(server)
				local s_opts = vim.tbl_deep_extend('force', {
					capabilities = vim.deepcopy(capabilities),
				}, opts.servers[server] or {})

				require('lspconfig')[server].setup(s_opts)
			end

			-- check to setup manually in case no support from mason
			for server, _ in pairs(opts.servers) do
				-- stylua: ignore
				if not vim.tbl_contains(mslp_servers, server) then
					s_setup(server)
				end
			end

			-- check to setup with mason-lspconfig
			if have_mason then
				mlsp.setup_handlers({ s_setup })
			end
		end,
		dependencies = {
			-- load for lsp server setup
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			{
				'hrsh7th/cmp-nvim-lsp',
				cond = function()
					return util.has('nvim-cmp')
				end,
			},
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
			log_level = vim.log.levels.INFO,
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

	-- null-ls as formatter and linter
	{
		'jose-elias-alvarez/null-ls.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = function()
			local nls = require('null-ls')
			return {
				sources = option.plugins.nls_sources(nls),
			}
		end,
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
	},

	-- better diagnostics list and others
	{
		'folke/trouble.nvim',
		cmd = { 'TroubleToggle', 'Trouble' },
		keys = keymap.trouble,
		opts = { use_diagnostic_signs = true },
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			'neovim/nvim-lspconfig',
		},
	},

	-- lsp symbol navigation for lualine
	{
		'SmiteshP/nvim-navic',
		lazy = true,
		init = function()
			-- vim.g.navic_silence = true
			util.on_attach(function(client, buffer)
				if client.server_capabilities.documentSymbolProvider then
					require('nvim-navic').attach(client, buffer)
				end
			end)
		end,
		opts = {
			highlight = true,
			depth_limit = 7,
			lsp = {
				auto_attach = true,
				preference = { 'clangd', 'pyright' },
			},
		},
		dependencies = {
			'neovim/nvim-lspconfig',
		},
	},
}
