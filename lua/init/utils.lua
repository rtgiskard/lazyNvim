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
	local enabled = vim.diagnostic.is_enabled()
	vim.diagnostic.enable(not enabled)
	M.notify_mini('󰨮 diagnostic: ' .. tostring(not enabled))
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

function M.trim_space()
	local view = vim.fn.winsaveview()
	vim.cmd([[%s/\s\+$//e]])
	vim.fn.winrestview(view)
	M.notify_mini('trimmed trailing space')
end

function M.session_file()
	local dir = vim.fn.stdpath('state') .. '/sessions'
	vim.fn.mkdir(dir, 'p')
	return dir .. '/' .. vim.fn.sha256(vim.fn.getcwd()) .. '.vim'
end

function M.save_session()
	local file = M.session_file()
	vim.cmd('mksession! ' .. vim.fn.fnameescape(file))
	M.notify_mini('session saved')
end

function M.load_session()
	local file = M.session_file()
	if vim.fn.filereadable(file) == 0 then
		M.notify_mini('session not found', vim.log.levels.WARN)
		return
	end
	vim.cmd('source ' .. vim.fn.fnameescape(file))
	M.notify_mini('session loaded')
end

-- utils for plugins

---@param plugin string
function M.has(plugin)
	return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

---@param msg string
---@param level? integer
function M.notify_mini(msg, level)
	vim.notify(
		msg,
		level or vim.log.levels.INFO,
		{ style = 'compact', title = '', icon = '' }
	)
end

function M.format()
	local have_fmt, fmt_util = pcall(require, 'conform')
	if have_fmt then
		-- get current formatter names
		local formatters, use_lsp = fmt_util.list_formatters_to_run()
		local fmt_names = {}

		if not vim.tbl_isempty(formatters) then
			fmt_names = vim.tbl_map(function(f)
				return f.name
			end, formatters)
		elseif use_lsp then
			fmt_names = { 'lsp' }
		else
			return
		end

		local fmt_info = 'fmt: ' .. table.concat(fmt_names, '/')
		local progress = require('fidget.progress').handle.create({
			title = fmt_info,
			message = 'running',
			lsp_client = { name = 'conform' },
			percentage = 0,
		})

		-- format with callback, and notify on err
		fmt_util.format(nil, function(err)
			progress:finish()
			if err then
				vim.notify(err, vim.log.levels.WARN, { title = fmt_info })
			end
		end)
	else
		vim.lsp.buf.format()
	end
end

return M
