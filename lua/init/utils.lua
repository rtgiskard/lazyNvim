local M = {}

function M.toggle_mouse()
	if vim.o.mouse == '' then
		vim.o.mouse = 'nvi'
		M.notify_mini('󰍽 mouse: ' .. vim.o.mouse)
	else
		vim.o.mouse = ''
		M.notify_mini('󰍾 mouse: -')
	end
end

function M.toggle_number()
	vim.o.number = not vim.o.number
	M.notify_mini(' line number: ' .. tostring(vim.o.number))
end

function M.toggle_listchars()
	vim.o.list = not vim.o.list
	M.notify_mini(' list chars: ' .. tostring(vim.o.list))
end

function M.toggle_diagnostic()
	local state = vim.diagnostic.is_disabled()
	if state then
		vim.diagnostic.enable()
	else
		vim.diagnostic.disable()
	end
	M.notify_mini('󰨮 diagnostic: ' .. tostring(state))
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

---@param msg string
---@param level? integer
function M.notify_mini(msg, level)
	vim.notify(msg, level or vim.log.levels.INFO, { render = 'minimal' })
end

function M.format()
	local format_args = require('init.options').plugins.format_args

	-- in case the original args get modified
	format_args = vim.deepcopy(format_args)

	local have_fmt, fmt_util = pcall(require, 'conform')
	if have_fmt then
		-- get current formatter names
		local formatters = fmt_util.list_formatters()
		local fmt_names = {}

		if not vim.tbl_isempty(formatters) then
			fmt_names = vim.tbl_map(function(f)
				return f.name
			end, formatters)
		elseif fmt_util.will_fallback_lsp(format_args) then
			fmt_names = { 'lsp' }
		else
			return
		end

		-- notify with noice progress api
		local noice_progress = require('noice.lsp.progress')

		local fmt_info = 'fmt: ' .. table.concat(fmt_names, '/')
		local msg_id = noice_progress.progress_msg(fmt_info)

		-- format with callback, and notify on err
		fmt_util.format(format_args, function(err)
			noice_progress.progress_msg_end(msg_id)
			if err then
				vim.notify(err, vim.log.levels.WARN, { title = fmt_info })
			end
		end)
	else
		vim.lsp.buf.format(format_args)
	end
end

return M
