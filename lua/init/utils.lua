local M = {}

function M.toggle_mouse()
	if vim.o.mouse == '' then
		vim.o.mouse = 'nvi'
		vim.notify('󰍽 mouse: ' .. vim.o.mouse, vim.log.levels.INFO)
	else
		vim.o.mouse = ''
		vim.notify('󰍾 mouse: ' .. vim.o.mouse, vim.log.levels.INFO)
	end
end

function M.toggle_number()
	vim.o.number = not vim.o.number
	vim.notify(' line number: ' .. tostring(vim.o.number), vim.log.levels.INFO)
end

function M.toggle_listchars()
	vim.o.list = not vim.o.list
	vim.notify(' list chars: ' .. tostring(vim.o.list), vim.log.levels.INFO)
end

function M.toggle_diagnostic()
	local state = vim.diagnostic.is_disabled()
	if state then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable()
	end
	vim.notify('󰨮 diagnostic: ' .. tostring(state), vim.log.levels.INFO)
end

function M.float_term(cmd, opts)
	local have_lazy, lazy_util = pcall(require, 'lazy.util')
	if have_lazy then
		opts = vim.tbl_deep_extend('force', {
			size = { width = 0.8, height = 0.7 },
		}, opts or {})
		lazy_util.float_term(cmd, opts)
	else
		vim.notify('`lazy.util` not found, abort!', vim.log.levels.WARN)
	end
end

-- utils for plugins

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

function M.format()
	local options = require('init.options')

	local have_fmt, fmt_util = pcall(require, 'conform')
	if have_fmt then
		fmt_util.format(options.plugins.format_args)
	else
		vim.lsp.buf.format(options.plugins.format_args)
	end
end

return M
