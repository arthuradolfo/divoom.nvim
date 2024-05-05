local settings = require( 'divoom.settings' )
local log = require( 'divoom-core.log' )

local M = {}

---@param address string
---@param icon string
local function config_server(address, icon)
	log.write(
		table.concat( { "Configuring server for client ", address } ),
		log.levels.INFO
	)

	local env_file_content = "PIXOO_HOST="..address..
	[[

		PIXOO_DEBUG=false
		PIXOO_SCREEN_SIZE=64
		PIXOO_REST_DEBUG=false
		PIXOO_REST_HOST=127.0.0.1
		PIXOO_REST_PORT=5000
	]]

	local fp = io.open( table.concat(
		{
			settings.current.install_root_dir,
			"/wifi",
			"/.env"
		}
	), "w" )

	if fp == nil then
		log.write( "Could not write .env file for wifi api.", log.levels.ERROR )
		return
	end

	fp:write( env_file_content )
	fp:close()

	vim.env.DIVOOM_ICON = icon

	log.write( "Server configured.", log.levels.INFO )
end

---@param address string
---@param icon string
function M.show_icon( address, icon )
	config_server( address, icon )

	vim.fn.jobstart( table.concat( {
		settings.current.install_root_dir,
		"/bash/",
		"wifiapi.sh"
	} ) )
end

return M
