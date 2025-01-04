-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Add logs with wezterm.log_info("hello")
-- See logs from wezterm: CTRL+SHIFT+L
--
-- Update all plugins:
-- wezterm.plugin.update_all()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Monokai Pro Ristretto (Gogh)"
config.color_scheme = "GruvboxDarkHard"
-- config.color_scheme = "GruvboxLight"
-- config.color_scheme = "Sonokai (Gogh)"
-- config.color_scheme = "Everforest Dark (Gogh)"
-- config.color_scheme = "Papercolor Light (Gogh)"
-- config.color_scheme = "Solarized Light (Gogh)"
-- config.color_scheme = "Vs Code Light+ (Gogh)"
-- config.color_scheme = "Modus-Operandi-Tinted"

local colors = wezterm.color.get_builtin_schemes()[config.color_scheme]
-- colors.background = "#1A1826" -- slightly darker background for catppuccin
wezterm.log_info(colors)
config.colors = {
	split = colors.foreground,
	tab_bar = {
		background = colors.background,
		active_tab = {
			bg_color = colors.background,
			fg_color = colors.foreground,
		},
		-- inactive_tab = {
		-- 	-- bg_color = colors.selection_bg,
		-- 	bg_color = colors.foreground,
		-- 	fg_color = colors.background,
		-- },
		-- inactive_tab_hover = {
		-- 	bg_color = colors.brights[8], -- lighter than colors.foreground
		-- 	fg_color = colors.background,
		-- },
	},
}

config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.93
config.macos_window_background_blur = 30
config.window_padding = {
	left = 0,
	right = 0,
	top = 10,
	bottom = 0,
}
config.pane_focus_follows_mouse = true

config.audible_bell = "SystemBeep"

config.automatically_reload_config = true
config.unicode_version = 14

config.cursor_blink_rate = 300
config.cursor_blink_ease_in = "EaseOut"

config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400

-- config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
-- config.font = wezterm.font("VictorMono Nerd Font Mono")
config.font = wezterm.font("Maple Mono")
config.font_size = 14.0
config.window_frame = {
	font = wezterm.font("Iosevka Aile"),
	font_size = 14.0,
}

config.animation_fps = 120
config.max_fps = 120
local available_gpus = wezterm.gui.enumerate_gpus()
config.webgpu_preferred_adapter = available_gpus[1] -- Evaluates to the integrated GPU in case of macOS
config.front_end = "WebGpu"

config.show_new_tab_button_in_tab_bar = false
-- config.show_close_tab_button_in_tabs = false
config.show_tab_index_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true
-- config.hide_tab_bar_if_only_one_tab = true

local function get_cwd(tab)
	local cwd = tab.active_pane and tab.active_pane.current_working_dir
	return string.gsub(cwd.file_path, "/Users/prayagmatic", "~")
end

-- References:
-- 1. https://github.com/wez/wezterm/blob/main/assets/shell-integration/wezterm.sh
-- 2. https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
-- 3. https://wezfurlong.org/wezterm/config/lua/PaneInformation.html
-- 4. https://wezfurlong.org/wezterm/config/lua/wezterm.url/Url.html
---@diagnostic disable-next-line: unused-local, redefined-local
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local cmdline = tab.active_pane.user_vars.WEZTERM_PROG or ""
	local cwd = get_cwd(tab)

	if cmdline == "" then
		return string.format("%s: %s", tab.tab_index + 1, cwd)
	elseif cwd == "~/" then
		return string.format("%s: %s", tab.tab_index + 1, cmdline)
	else
		return string.format("%s: %s @ %s", tab.tab_index + 1, cmdline, get_cwd(tab))
	end
end)

config.scrollback_lines = 1000000
-- open scrollback buffer in vim
-- Source: https://wezfurlong.org/wezterm/config/lua/wezterm/on.html#example-opening-whole-scrollback-in-vim
local io = require("io")
local os = require("os")
local act = wezterm.action

wezterm.on("trigger-vim-with-scrollback", function(window, pane)
	-- Retrieve the text from the pane
	local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

	-- Create a temporary file to pass to vim
	local name = os.tmpname()
	local f = io.open(name, "w+")
	if f ~= nil then
		f:write(text)
		f:flush()
		f:close()
	end

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

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
config.status_update_interval = 30000
---@diagnostic disable-next-line: unused-local
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = colors.foreground } },
		{ Text = "  Current workspace: " },
		{ Text = window:active_workspace() },
		{ Text = "  " },
	}))
end)

config.unix_domains = { { name = "unix" } }
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.periodic_save({ interval_seconds = 15 * 60, save_workspaces = true, save_windows = true, save_tabs = true })
-- Source: plugin README
-- loads the state whenever I create a new workspace
---@diagnostic disable-next-line: unused-local
wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)
-- Saves the state whenever I select a workspace
---@diagnostic disable-next-line: unused-local
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	local workspace_state = resurrect.workspace_state
	resurrect.save_state(workspace_state.get_workspace_state())
end)
-- resurrect on startup
wezterm.on("gui-startup", resurrect.resurrect_on_gui_startup)

config.ui_key_cap_rendering = "UnixLong"
-- https://wezfurlong.org/wezterm/config/keys.html?#leader-key
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {

	{ key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
	{ key = "y", mods = "LEADER", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "k", mods = "CTRL", action = act.ClearScrollback("ScrollbackOnly") },
	{ key = "?", mods = "LEADER", action = act.ShowDebugOverlay },
	{ key = "r", mods = "LEADER", action = act.ReloadConfiguration },

	-- shell integration
	{ key = "P", mods = "LEADER", action = act.ScrollToPrompt(-1) },
	{ key = "N", mods = "LEADER", action = act.ScrollToPrompt(1) },
	{ key = "V", mods = "LEADER", action = act.SelectTextAtMouseCursor("SemanticZone") },
	{
		key = "e",
		mods = "LEADER",
		action = act.EmitEvent("trigger-vim-with-scrollback"),
	},

	-- session/workspace management
	{ key = "f", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY | WORKSPACES | DOMAINS" }) },
	{
		key = "s",
		mods = "LEADER",
		action = workspace_switcher.switch_workspace(),
	},
	{ key = "a", mods = "LEADER", action = act.AttachDomain("unix") },
	{ key = "d", mods = "LEADER", action = act.DetachDomain("CurrentPaneDomain") },

	-- tabs
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{
		key = "]",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "[",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.ShowTabNavigator,
	},

	-- panes
	{
		key = "\\",
		mods = "LEADER",
		action = act.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "-",
		mods = "LEADER",
		action = act.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{ key = "o", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "T", mods = "LEADER", action = act.PaneSelect({ mode = "MoveToNewTab" }) },
	{ key = "9", mods = "LEADER", action = act.PaneSelect({ mode = "Activate" }) },
	{ key = "0", mods = "LEADER", action = act.PaneSelect({ mode = "SwapWithActive" }) },
	{
		key = "L",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "K",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "Q",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "J",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "H",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},

	-- disable key bindings that conflict with vim
	{ key = "P", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "P", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
	{ key = "p", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
	{ key = "h", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
	{ key = "j", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
	{ key = "k", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
	{ key = "l", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
}

-- ctrl - x for activating tab x
for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL",
		action = act.ActivateTab(i - 1),
	})
end

-- and finally, return the configuration to wezterm
return config
