-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Everforest Dark (Gogh)"
-- config.color_scheme = "Monokai Pro Ristretto (Gogh)"
config.color_scheme = "GruvboxDarkHard"

local colors = wezterm.color.get_builtin_schemes()[config.color_scheme]
-- colors.background = "#1A1826" -- slightly darker background for catppuccin
-- wezterm.log_info(colors)
config.colors = {
	split = colors.foreground,
	tab_bar = {
		background = colors.background,
		active_tab = {
			bg_color = colors.background,
			fg_color = colors.foreground,
		},
		inactive_tab = {
			bg_color = colors.selection_bg,
			fg_color = colors.foreground,
		},
		inactive_tab_hover = {
			bg_color = colors.brights[8], -- lighter than colors.foreground
			fg_color = colors.background,
		},
	},
}
-- config.force_reverse_video_cursor = true

config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.93
config.macos_window_background_blur = 30
config.window_frame = {
	font = wezterm.font("Iosevka Aile"),
	font_size = 14.0,
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 10,
	bottom = 0,
}

config.animation_fps = 120
config.max_fps = 120
config.audible_bell = "SystemBeep"
config.automatically_reload_config = true
config.cursor_blink_rate = 500

-- config.font = wezterm.font("Iosevka Term")
config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
config.font_size = 15.0

config.front_end = "WebGpu"

config.show_new_tab_button_in_tab_bar = false

config.ui_key_cap_rendering = "UnixLong"

config.unicode_version = 14

config.scrollback_lines = 50000

-- open scrollback buffer in vim
-- Source: https://wezfurlong.org/wezterm/config/lua/wezterm/on.html#example-opening-whole-scrollback-in-vim
local io = require("io")
local os = require("os")

wezterm.on("trigger-vim-with-scrollback", function(window, pane)
	-- Retrieve the text from the pane
	local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

	-- Create a temporary file to pass to vim
	local name = os.tmpname()
	local f = io.open(name, "w+")
	f:write(text)
	f:flush()
	f:close()

	-- Open a new window running vim and tell it to open the file
	window:perform_action(
		act.SpawnCommandInNewWindow({
			args = { "/Users/prayagmatic/.config/zsh/zinit/polaris/bin/nvim", name },
		}),
		pane
	)

	-- Wait "enough" time for vim to read the file before we remove it.
	-- The window creation and process spawn are asynchronous wrt. running
	-- this script and are not awaitable, so we just pick a number.
	--
	-- Note: We don't strictly need to remove this file, but it is nice
	-- to avoid cluttering up the temporary directory.
	wezterm.sleep_ms(1000)
	os.remove(name)
end)

local act = wezterm.action
config.keys = {}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = act.ActivateTab(i - 1),
	})
end

config.keys = {
	{
		key = "]",
		mods = "SUPER | CTRL",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "[",
		mods = "SUPER | CTRL",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "SUPER | SHIFT",
		action = act.MoveTabRelative(1),
	},
	{
		key = "[",
		mods = "SUPER | SHIFT",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "\\",
		mods = "SUPER | CTRL",
		action = act.SplitPane({
			direction = "Right",
		}),
	},
	{
		key = "Enter",
		mods = "SUPER | CTRL",
		action = act.SplitPane({
			direction = "Down",
		}),
	},
	{
		key = "l",
		mods = "SUPER | CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "SUPER | CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "SUPER | CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "h",
		mods = "SUPER | CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{ key = "k", mods = "SUPER | SHIFT", action = act.ScrollToPrompt(-1) },
	{ key = "j", mods = "SUPER | SHIFT", action = act.ScrollToPrompt(1) },
	{
		key = "e",
		mods = "SUPER | CTRL",
		action = act.EmitEvent("trigger-vim-with-scrollback"),
	},
}

-- Lua ftw
-- References:
-- 1. https://github.com/wez/wezterm/blob/main/assets/shell-integration/wezterm.sh
-- 2. https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
-- 3. https://wezfurlong.org/wezterm/config/lua/PaneInformation.html
-- 4. https://wezfurlong.org/wezterm/config/lua/wezterm.url/Url.html
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	-- wezterm.log_info(pane.user_vars.WEZTERM_PROG)
	local title = pane.user_vars.WEZTERM_PROG or ""
	if title == "" then
		local url = pane.current_working_dir or ""
		if url.file_path == "/Users/prayagmatic/" then
			title = "~"
		else
			title = string.gsub(url.file_path, "/Users/prayagmatic/", "~/")
		end
	end
	return string.format(" %s ", title)
end)

-- and finally, return the configuration to wezterm
return config
