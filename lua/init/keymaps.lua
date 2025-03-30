local M = {}

local util = require('init.utils')

-- keymaps generic

M.basic = {
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

-- keymaps for plugins

M.snacks = function()
	local S = {}
	setmetatable(S, {
		__index = function(_, k)
			return function()
				local mod = (k == 'explorer') and 'snacks' or 'snacks.picker'
				require(mod)[k]()
			end
		end,
	})

	return {
		{ '<F1>', S.explorer, desc = 'file explorer' },

		{ '<leader>fb', S.buffers, desc = 'find buffers' },
		{ '<leader>ff', S.files, desc = 'find files' },
		{ '<leader>fg', S.grep, desc = 'text grep' },
		{ '<leader>fh', S.help, desc = 'help pages' },

		{ '<leader>sj', S.jumps, desc = 'Jumps' },
		{ '<leader>sk', S.keymaps, desc = 'Keymaps' },
		{ '<leader>sl', S.loclist, desc = 'Location List' },
		{ '<leader>sq', S.qflist, desc = 'Quickfix List' },
		{ '<leader>sm', S.marks, desc = 'Marks' },

		{ '<leader>sd', S.diagnostics, desc = 'diagnostics' },
		{ '<leader>sD', S.diagnostics_buffer, desc = 'diagnostics buffer' },

		{ 'gd', S.lsp_definitions, desc = 'Goto Definition' },
		{ 'gD', S.lsp_declarations, desc = 'Goto Declaration' },
		{ 'gr', S.lsp_references, nowait = true, desc = 'References' },
		{ 'gI', S.lsp_implementations, desc = 'Goto Implementation' },
		{ 'gy', S.lsp_type_definitions, desc = 'Goto Type Definition' },

		{ '<leader>gs', S.lsp_symbols, desc = 'LSP Symbols' },
		{ '<leader>gS', S.lsp_workspace_symbols, desc = 'LSP Workspace Symbols' },
	}
end

M.trouble = { { '<F2>', ':Trouble<cr>', desc = 'Toggle Trouble' } }

M.trim = {
	{ '<C-1>', ':Trim<cr>', desc = 'Trim Space' },
}

M.notify = {
	{
		'<C-2>',
		function()
			require('notify').dismiss({ silent = true, pending = true })
		end,
		desc = 'Silent Popup Notifications',
	},
}

-- stylua: ignore
M.persistence = {
	{ '<leader>Ss', function() require('persistence').save() end, desc = 'Save Session' },
	{ '<leader>Sl', function() require('persistence').load() end, desc = 'Load Session' },
}

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

	{ '<leader>cl', ':LspInfo<cr>', desc = 'Lsp Info' },
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

M.todo_comments = {
	{ '<leader>xt', ':TodoTrouble<cr>', desc = 'Todo Trouble' },
	{ '<leader>st', ':TodoTelescope<cr>', desc = 'Todo Search' },
}

-- mini.comment: internal map in opts
M.mini_comment = {
	-- Use `''` (empty string) to disable one.

	comment = '', -- Toggle comment for both Normal and Visual modes
	comment_line = 'cc', -- Toggle comment on current line
	comment_visual = 'cc', -- Toggle comment on visual selection

	-- Define 'comment' textobject (like `dgc` - delete whole comment block)
	textobject = '',
}

-- ts-refactor: internal map
M.ts_refactor = {
	rename = { smart_rename = 'gR' },
	navigate = {
		goto_definition = 'gd',
		list_definitions = 'gl',
		list_definitions_toc = 'gL',
		goto_next_usage = false,
		goto_previous_usage = false,
	},
}

function M.load_keymaps()
	for _, km in ipairs(M.basic) do
		local mode = km.mode or { 'n', 'v', 'o' }
		vim.keymap.set(mode, km[1], km[2], { desc = km.desc })
	end
end

return M
