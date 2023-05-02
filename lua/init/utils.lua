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
end

function M.toggle_listchars()
	vim.o.list = not vim.o.list
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

---@param plugin string
function M.has(plugin)
	return require('lazy.core.config').plugins[plugin] ~= nil
end

function M.format()
	local buf = vim.api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype

	-- stylua: ignore
	local have_nls = #require('null-ls.sources').get_available(ft, 'NULL_LS_FORMATTING') > 0

	-- prefer null-ls formatter
	local fmt_filter = function(client)
		if have_nls then
			return client.name == 'null-ls'
		end
		return client.name ~= 'null-ls'
	end

	vim.lsp.buf.format({
		bufnr = buf,
		filter = fmt_filter,
		timeout_ms = require('init.options').plugins.fmt_timeout_ms,
	})
end

return M
