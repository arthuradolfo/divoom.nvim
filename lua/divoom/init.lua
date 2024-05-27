local btapi		= require( "divoom-core.btapi" )
local wifiapi	= require( "divoom-core.wifiapi" )
local settings	= require( "divoom.settings" )

local M = {}

M.has_setup = false
M.show_icons = true

local function setup_autocmds()
	for language, file_extensions in pairs(settings.current.languages_mapping) do
		vim.api.nvim_create_autocmd({"BufEnter"}, {
			pattern = file_extensions,
			callback = function()
				if M.show_icons == false then
					return
				end
				local i = 1
				for _, devices in pairs(settings.current.devices) do
					if devices.type == "IP" then
						wifiapi.show_icon( devices.address, settings.current.icons_mapping[language][i] )
					elseif devices.type == "BT" then
						btapi.show_icon( devices.address, settings.current.icons_mapping[language][i] )
					end
					i = i + 1
				end
			end
		})
	end
end

---@param config DivoomSettings?
function M.setup(config)
    if config then
        settings.set(config)
    end

	os.execute( "mkdir -p " .. settings.current.install_root_dir .. "/log" )

    vim.env.DIVOOM = settings.current.install_root_dir

    require "divoom.api.command"
    setup_autocmds()
    M.has_setup = true
end

return M
