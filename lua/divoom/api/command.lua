local divoom = require('divoom.init')

local function DivoomToggleIcons()
    divoom.show_icons = not divoom.show_icons
end

vim.api.nvim_create_user_command("DivoomToggleIcons", DivoomToggleIcons, {
    desc = "Toggles divoom's icon showing.",
    nargs = 0,
})
