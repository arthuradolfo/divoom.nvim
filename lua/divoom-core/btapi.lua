local settings = require( 'divoom.settings' )
local log = require( 'divoom-core.log' )

local M = {}

---@param address string
---@param icon string
function M.show_icon( address, icon )
	log.write( "Sending icon information for bluetooth device"..address..".", log.levels.INFO )
	os.execute(
		table.concat( {
			settings.current.install_root_dir,
			"/bt/",
			"bt.js ",
			address,
			" ",
			icon,
		})
	)
	log.write( "Icon sent.", log.levels.INFO )
end

return M

