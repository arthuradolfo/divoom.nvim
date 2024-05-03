local btapi		= require( "divoom-core.btapi" )
local wifiapi	= require( "divoom-core.wifiapi" )
local settings	= require( "divoom.settings" )

local M = {}

local function setup_autocmds()
	for language, file_extensions in pairs(settings.current.languages_mapping) do
		vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
			pattern = file_extensions,
			callback = function()
				if M.show_icons == false then
					return
				end
				local i = 0
				for _, devices in pairs(settings.current.devices) do
					if devices.type == "IP" then
						wifiapi.send_icon( devices.address, settings.current.icons_mapping[language][i] )
					elseif devices.type == "BT" then
						btapi.send_icon( devices.address, settings.current.icons_mapping[language][i] )
					end
					i = i + 1
				end
			end
		})
	end
end

M.has_setup = false
M.show_icons = true

---@param config DivoomSettings?
function M.setup(config)
    if config then
        settings.set(config)
    end

	os.execute( "mkdir " .. settings.current.install_root_dir )
	os.execute( "mkdir " .. settings.current.install_root_dir .. "log" )

    vim.env.DIVOOM = settings.current.install_root_dir

    require "divoom.api.command"
    setup_autocmds()
    M.has_setup = true
end

return M
