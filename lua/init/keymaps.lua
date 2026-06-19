local M = {}

local util = require('init.utils')

-- keymaps generic

M.basic = {
	{ '<F1>', '<nop>', mode = { 'n', 'i', 'v' }, desc = 'unbind :help' },

	{ '<esc><esc>', '<c-\\><c-n>', mode = 't', desc = 'Normal Mode' },

	{ '<C-t>', util.float_term, desc = 'Float Terminal' },

	{ '<S-F1>', util.toggle_mouse, desc = 'Toggle Mouse' },
	{ '<S-F2>', util.toggle_number, desc = 'Toggle Number' },
	{ '<S-F3>', util.toggle_listchars, desc = 'Toggle ListChars' },
	{ '<S-F4>', util.toggle_diagnostic, desc = 'Toggle Diagnostic' },
	-- for compatability: `S-F2` == `F14` and etc.
	{ '<F13>', util.toggle_mouse, desc = 'Toggle Mouse' },
	{ '<F14>', util.toggle_number, desc = 'Toggle Number' },
	{ '<F15>', util.toggle_listchars, desc = 'Toggle ListChars' },
	{ '<F16>', util.toggle_diagnostic, desc = 'Toggle Diagnostic' },
}

-- keymaps core

M.core = {
	-- edit
	{ '<C-1>', util.trim_space, desc = 'Trim Space' },
	{ 'cc', 'gcc', desc = 'Toggle Comment', remap = true },
	{ 'cc', 'gc', mode = 'x', desc = 'Toggle Comment', remap = true },

	-- outline
	{
		'<F3>',
		function()
			require('snacks').picker.lsp_symbols()
		end,
		desc = 'symbols',
	},
	{
		'<F4>',
		function()
			require('snacks').picker.diagnostics()
		end,
		desc = 'diagnostics',
	},

	-- session
	{ '<leader>Ss', util.save_session, desc = 'Save Session' },
	{ '<leader>Sl', util.load_session, desc = 'Load Session' },
}

-- keymaps for plugins

M.snacks = function()
	local S = {}
	setmetatable(S, {
		__index = function(_, k)
			if k == 'explorer' then
				return function(...)
					return require('snacks').explorer(...)
				end
			end
			return setmetatable({}, {
				__index = function(_, sub_k)
					return function(...)
						return require('snacks')[k][sub_k](...)
					end
				end,
			})
		end,
	})

	return {
		{ '<F1>', S.explorer, desc = 'file explorer' },
		{ '<C-2>', S.notifier.hide, desc = 'hide notifier' },

		{ '<leader>fb', S.picker.buffers, desc = 'find buffers' },
		{ '<leader>ff', S.picker.files, desc = 'find files' },
		{ '<leader>fg', S.picker.grep, desc = 'text grep' },
		{ '<leader>fh', S.picker.help, desc = 'help pages' },

		{ '<leader>sj', S.picker.jumps, desc = 'Jumps' },
		{ '<leader>sk', S.picker.keymaps, desc = 'Keymaps' },
		{ '<leader>sl', S.picker.loclist, desc = 'Location List' },
		{ '<leader>sq', S.picker.qflist, desc = 'Quickfix List' },
		{ '<leader>sm', S.picker.marks, desc = 'Marks' },

		{ '<leader>sD', S.picker.diagnostics, desc = 'diagnostics global' },
		{ '<leader>sd', S.picker.diagnostics_buffer, desc = 'diagnostics' },
		{ '<leader>ss', S.picker.lsp_symbols, desc = 'symbols' },
		{ '<leader>sS', S.picker.lsp_workspace_symbols, desc = 'symbols global' },
		{ '<leader>st', S.picker.todo_comments, desc = 'todo' },

		{ 'gd', S.picker.lsp_definitions, desc = 'Goto Definition' },
		{ 'gD', S.picker.lsp_declarations, desc = 'Goto Declaration' },
		{ 'gr', S.picker.lsp_references, nowait = true, desc = 'References' },
		{ 'gI', S.picker.lsp_implementations, desc = 'Goto Implementation' },
		{ 'gy', S.picker.lsp_type_definitions, desc = 'Goto Type Definition' },
	}
end

M.cmp = {
	preset = 'none',

	['<CR>'] = { 'accept', 'fallback' },
	['<C-Tab>'] = { 'show', 'show_documentation', 'hide_documentation' },

	['<Tab>'] = { 'snippet_forward', 'fallback' },
	['<S-Tab>'] = { 'snippet_backward', 'fallback' },

	['<C-e>'] = { 'hide' },
	['<C-y>'] = { 'select_and_accept' },

	['<Up>'] = { 'select_prev', 'fallback' },
	['<Down>'] = { 'select_next', 'fallback' },
	['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
	['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
}

M.lsp = {
	{ 'K', vim.lsp.buf.hover, desc = 'Hover' },

	{ '<C-d>', vim.diagnostic.open_float, desc = 'Line Diagnostics' },
	{ '<C-k>', vim.lsp.buf.signature_help, mode = '', desc = 'Signature Help' },
	{ '<C-a>', vim.lsp.buf.code_action, mode = { 'n', 'v' }, desc = 'Code Action' },

	{ '<C-f>', util.format, desc = 'Format' },

	{ '<leader>cR', vim.lsp.buf.rename, desc = 'Lsp Rename' },
}

-- stylua: ignore
M.dap = {
		-- use `dc` to start/continue, ref: `:help dap-api`
	{ '<leader>dc', function() require('dap').continue() end, desc = 'Start/Continue' },
	{ '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
	{ '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },

	{ '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
	{ '<leader>dL', function() require('dap').list_breakpoints() end, desc = 'List Breakpoint' },

	-- REPL window also provide control with interactive commands or mouse
	{ '<leader>dn', function() require('dap').step_over() end, desc = 'Step Over' },
	{ '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
	{ '<leader>do', function() require('dap').step_out() end, desc = 'Step Out' },

	{ '<leader>dk', function() require('dap').up() end, desc = 'Up in Stacktrace' },
	{ '<leader>dj', function() require('dap').down() end, desc = 'Down in Stacktrace' },

	-- REPL: provide command line input/output, better to work with mouse or dap-ui
	{ '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
}

-- stylua: ignore
M.dapui = {
	{ '<leader>du', function() require('dapui').toggle() end, desc = 'DapUI toggle' },
	{ '<leader>de', function() require('dapui').eval() end, desc = 'DapUI eval' },
}

local function set_keymaps(maps)
	for _, km in ipairs(maps) do
		local mode = km.mode or 'n'
		vim.keymap.set(mode, km[1], km[2], { desc = km.desc, remap = km.remap })
	end
end

function M.load_keymaps()
	set_keymaps(M.basic)
	set_keymaps(M.core)
end

return M
