local M = {}

local util = require('init.utils')

-- keymaps generic

M.basic = {
	{ '<esc><esc>', '<c-\\><c-n>', mode = 't', desc = 'Normal Mode' },

	{ '<C-t>', util.float_term, desc = 'Float Terminal' },

	{ '<S-F1>', util.toggle_number, desc = 'Toggle Number' },
	{ '<S-F2>', util.toggle_mouse, desc = 'Toggle Mouse' },
	{ '<S-F3>', util.toggle_listchars, desc = 'Toggle ListChars' },
	-- for compatability: `S-F2` == `F14` and etc.
	{ '<F13>', util.toggle_number, desc = 'Toggle Number' },
	{ '<F14>', util.toggle_mouse, desc = 'Toggle Mouse' },
	{ '<F15>', util.toggle_listchars, desc = 'Toggle ListChars' },
}

-- keymaps for plugins

M.neotree = { { '<F1>', '<cmd>Neotree toggle<cr>', desc = 'Toggle Neotree' } }
M.trouble = { { '<F2>', '<cmd>TroubleToggle<cr>', desc = 'Toggle Trouble' } }

M.trim = {
	{ '<C-1>', '<cmd>Trim<cr>', desc = 'Trim Space' },
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

M.bufferline = {
	{ '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
	{
		'<leader>bP',
		'<Cmd>BufferLineGroupClose ungrouped<CR>',
		desc = 'Delete non-pinned buffers',
	},
}

M.telescope = {
	{ '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'TL file' },
	{ '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'TL grep' },
	{ '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'TL buffer' },
	{ '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'TL tags' },
}

-- stylua: ignore
M.spectre = { { '<leader>sr', function() require('spectre').open() end }, desc = 'Spectre' }

-- stylua: ignore
M.persistence = {
	{ '<leader>Ss', function() require('persistence').save() end, desc = 'Save Session' },
	{ '<leader>Sl', function() require('persistence').load() end, desc = 'Load Session' },
}

M.lsp = {
	{ 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
	{ 'gr', '<cmd>Telescope lsp_references<cr>', desc = 'Goto References' },
	{ 'gd', '<cmd>Telescope lsp_definitions<cr>', desc = 'Goto Definition' },
	{ 'gI', '<cmd>Telescope lsp_implementations<cr>', desc = 'Goto Implementation' },
	{ 'gt', '<cmd>Telescope lsp_type_definitions<cr>', desc = 'Goto Type Definition' },

	{ 'K', vim.lsp.buf.hover, desc = 'Hover' },

	{ '<C-d>', vim.diagnostic.open_float, desc = 'Line Diagnostics' },
	{ '<C-k>', vim.lsp.buf.signature_help, mode = '', desc = 'Signature Help' },
	{ '<C-a>', vim.lsp.buf.code_action, mode = { 'n', 'v' }, desc = 'Code Action' },

	{ '<C-f>', util.format, desc = 'Format' },

	{ '<leader>cl', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
}

M.todo_comments = {
	{ '<leader>xt', '<cmd>TodoTrouble<cr>', desc = 'Todo Trouble' },
	{ '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo Search' },
}

-- mini.comment: internal map in opts
M.mini_comment = {
	-- Use `''` (empty string) to disable one.

	comment = 'gc', -- Toggle comment for both Normal and Visual modes
	comment_line = 'gcc', -- Toggle comment on current line

	-- Define 'comment' textobject (like `dgc` - delete whole comment block)
	textobject = 'gc',
}

-- nvim-cmp: internal map in opts
M.cmp_mapping = function(cmp)
	-- stylua: ignore
	return cmp.mapping.preset.insert({
		['<C-Tab>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-n>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
		['<C-p>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<S-CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	})
end

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
