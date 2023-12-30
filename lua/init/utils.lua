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

---@param title string
---@param msg? string
function M.init_msg_progress(title, msg)
	return require('fidget.progress').handle.create({
		title = title,
		message = msg,
		lsp_client = { name = '>>' }, -- the fake lsp client name
		percentage = nil, -- skip percentage field
	})
end

function M.format()
	local format_args = require('init.options').plugins.format_args

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

		local fmt_info = 'fmt: ' .. table.concat(fmt_names, '/')
		local msg_handle = M.init_msg_progress(fmt_info)

		-- format with auto close popup, and notify if err
		fmt_util.format(format_args, function(err)
			msg_handle:finish()
			if err then
				vim.notify(err, vim.log.levels.WARN, { title = fmt_info })
			end
		end)
	else
		vim.lsp.buf.format(format_args)
	end
end

return M
