local settings = require( 'divoom.settings' )
local log = require( 'divoom-core.log' )

local M = {}

M.server_started = false

---@param icon string
-- Sends a post with icon path to Wifi Device
local function send_icon( icon )
	os.execute(
		"curl -X 'POST' "..
		"'http://localhost:5000/image' "..
		"-H 'accept: application/json' "..
		"-H 'Content-Type: multipart/form-data' "..
		"-F \"image=@"..
		table.concat(
			{
				settings.current.install_root_dir,
				"/icons/",
				icon
			}
		)..
		";type=image/png\" "..
		"-F 'x=45' "..
		"-F 'y=16' "..
		"-F 'push_immediately=true'"
	)
end

---@param address string
function M.start_server(address)
	log.write(
		table.concat( { "Starting server for client ", address } ),
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

	os.execute(
		table.concat( {
			"docker-compose -f ",
			settings.current.install_root_dir, "/wifi/docker-compose.yml",
			" up -d"
		} )
	)

	log.write( "Server started.", log.levels.INFO )
end

function M.stop_server()
	os.execute(
		table.concat( {
			"docker-compose -f ",
			settings.current.install_root_dir, "/wifi/docker-compose.yml",
			" down"
		} )
	)
end

---@param address string
---@param icon string
function M.show_icon( address, icon )
	M.start_server( address )

	send_icon( icon )

	M.stop_server()
end

return M
