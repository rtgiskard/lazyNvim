local keymap = require('init.keymaps')

return {
	-- debug adapter protocol client
	{
		'mfussenegger/nvim-dap',
		lazy = true,
		keys = keymap.dap,
		config = function()
			local icon_map = {
				Breakpoint = { ' ' },
				BreakpointCondition = { ' ' },
				BreakpointRejected = { ' ', 'DiagnosticError' },
				LogPoint = { ' ' },
				Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
			}

			-- stylua: ignore
			vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

			for name, sign in pairs(icon_map) do
				vim.fn.sign_define('Dap' .. name, {
					text = sign[1],
					texthl = sign[2] or 'DiagnosticInfo',
					linehl = sign[3],
					numhl = sign[3],
				})
			end

			-- setup adapter and config for specific language
			local dap = require('dap')

			-- dap: c/cpp/rust
			-- req: gdb 14.0+
			dap.adapters.gdb = {
				type = 'executable',
				command = 'gdb',
				args = { '-i', 'dap' },
			}
			-- req: lldb
			dap.adapters.lldb = {
				type = 'executable',
				command = 'lldb-vscode',
				name = { 'lldb' },
			}
			dap.configurations.c = {
				{
					name = 'Launch',
					type = 'lldb',
					request = 'launch',

					program = function()
						return vim.fn.input(
							'Path to executable: ',
							vim.fn.getcwd() .. '/',
							'file'
						)
					end,
					args = function()
						local args = vim.fn.input('Args: ')
						return vim.split(args, ' ')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
				},
			}
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.rust = dap.configurations.c

			-- dap: python
			dap.adapters.debugpy = {
				type = 'executable',
				command = '/usr/bin/python',
				args = { '-m', 'debugpy.adapter' },
			}
			dap.configurations.python = {
				{
					-- required by nvim-dap
					name = 'Launch',
					type = 'debugpy',
					request = 'launch',

					-- options below are for debugpy
					pythonPath = 'python',
					program = function()
						return vim.fn.input(
							'Path to executable: ',
							vim.fn.getcwd() .. '/',
							'file'
						)
					end,
					args = function()
						local args = vim.fn.input('Args: ')
						return vim.split(args, ' ')
					end,
					cwd = '${workspaceFolder}',
				},
			}
		end,
	},

	-- fancy UI for the debugger
	{
		'rcarriga/nvim-dap-ui',
		lazy = true,
		keys = keymap.dapui,
		config = function(_, opts)
			local dap, dapui = require('dap'), require('dapui')
			dapui.setup(opts)
			dap.listeners.after.event_initialized['dapui_config'] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated['dapui_config'] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited['dapui_config'] = function()
				dapui.close()
			end
		end,
		dependencies = {
			'mfussenegger/nvim-dap',
			'theHamsta/nvim-dap-virtual-text',
		},
	},

	-- dap virtual text support
	{
		'theHamsta/nvim-dap-virtual-text',
		lazy = true,
		opts = {},
	},
}
