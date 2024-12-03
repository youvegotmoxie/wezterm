-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- Configure tabs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.show_tabs_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = false
config.tab_and_split_indices_are_zero_based = false
config.tab_bar_at_bottom = true
config.tab_max_width = 25
config.use_fancy_tab_bar = false

-- Configure GPU
config.front_end = "WebGpu"
config.webgpu_force_fallback_adapter = false

-- Set colorscheme
config.color_scheme = "Tokyo Night"

-- Set font and size
config.font = wezterm.font("MesloLGS NF")
config.font_size = 13.0

-- Setup tab bar plugin
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		icons_enabled = false,
		theme = "Tokyo Night",
	},
	sections = {
		tabline_a = { "" },
		tabline_x = { "ram", "cpu", throttle = 5 },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "" },
	},
})

-- Configure keymaps
local act = wezterm.action
config.keys = {
	{ key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "Enter", mods = "CMD|SHIFT", action = act.TogglePaneZoomState },
	{ key = "[", mods = "CMD", action = act.ActivatePaneDirection("Up") },
	{ key = "]", mods = "CMD", action = act.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "CMD|SHIFT", action = act.ScrollToPrompt(-1) },
	{ key = "DownArrow", mods = "CMD|SHIFT", action = act.ScrollToPrompt(1) },
}

-- and finally, return the configuration to wezterm
return config
