local settings = require( 'divoom.settings' )

local M = {}

M.levels = { INFO = "INFO", WARN = "WARN", ERROR =  "ERROR", DEBUG = "DEBUG" }

M.log_file_open = false

M.fp = nil

function M.open_log_file()
	M.fp = io.open( settings.current.log_file, "a+" )
	M.log_file_open = true
end

---@param msg string
---@param level string
function M.write( msg, level )
	if M.log_file_open == false then
		M.open_log_file()
	end

	local current_date = table.concat(
		{ "[", os.date( "%Y-%m-%d %H:%M:%S" ), "] " }
	)

	M.fp:write( table.concat( { current_date, level, ": ", msg } ) )
	M.fp:flush()
end

function M.close_log_file()
	M.fp:close()
end

return M
