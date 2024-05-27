local M = {}

---@class DivoomSettings
local DEFAULT_SETTINGS = {
	---@since 1.0.0
	-- Directory to install dependencies (divoom api clients)
	install_root_dir = table.concat(
		{ vim.fn.stdpath "data", "/plugged", "/divoom.nvim" }
	),

	---@since 1.0.0
	-- Log file
	log_file = table.concat(
		{ vim.fn.stdpath "data", "/plugged", "/divoom.nvim", "/log", "/log.txt" }
	),

	---@since 1.0.0
	-- File extensions mapping
	-- Sets which file extensions are mapped to which programming language
	languages_mapping = {
		julia		=	{ "*.jl" },
		cplusplus	=	{ "*.cpp", "*.hpp" },
		c			=	{ "*.c", "*.h" },
		go			=	{ "*.go" },
		lua			=	{ "*.lua" },
		python		=	{ "*.py" },
		basic		=	{ "*.bas", "*.bpp" },
		javascript	=	{ "*.js" }
	},

	---@since 1.0.0
	-- Icons mapping
	-- Sets which icon is showed up in each device for each programming language
	-- Three devices supported
	--	Pixoo64
	--	DitooPro
	--	TimeboxEvo
	icons_mapping = {
		julia		=	{ "julialang.png", "julialang.png", "julialang.png" },
		cplusplus	=	{ "cplusplus.png", "cplusplus.png", "cplusplus.png" },
		c			=	{ "c.png", "c.png", "c.png" },
		go			=	{ "golang.png", "golang.png", "golang.png" },
		lua			=	{ "lua.png", "lua.png", "lua.png" },
		python		=	{ "python.png", "python.png", "python.png" },
		basic		=	{ "basic.png", "basic.png", "basic.png" },
		javascript	=	{ "js.png", "js.png", "js.png" }
	},

	---@since 1.0.0
	-- Devices table
	-- Contains all devices registered by user, contains their IP or BT address
	-- eg. devices = { mypixoo64 = IP, mytimebox = BTID }
	-- Number of icons per language on icons_mapping should match with number 
	-- of devices here
	devices = {
		mypixoo64	= { address = "192.168.0.1", type = "IP" },
		mytimebox	= { address = "FF:FF:FF:FF:FF:FF", type = "BT" },
		myditoo		= { address = "FF:FF:FF:FF:FF:FF", type = "BT" },
	}
}

M.DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = DEFAULT_SETTINGS

---@param opts DivoomSettings
function M.set(opts)
    M.current = vim.tbl_deep_extend("force", vim.deepcopy(M.current), opts)
end

return M
