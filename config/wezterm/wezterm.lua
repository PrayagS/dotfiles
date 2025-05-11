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
-- wezterm.log_info(colors)
config.colors = {
	split = colors.foreground,
	tab_bar = {
		background = colors.foreground,
		active_tab = {
			bg_color = colors.foreground,
			fg_color = colors.background,
		},
		inactive_tab = {
			bg_color = colors.brights[1],
			fg_color = "#3c3836",
		},
		inactive_tab_hover = {
			bg_color = colors.ansi[8], -- lighter than colors.foreground
			fg_color = "#3c3836",
		},
	},
}

config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "MACOS_FORCE_DISABLE_SHADOW | RESIZE"
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
config.notification_handling = "AlwaysShow"

config.automatically_reload_config = true
config.unicode_version = 14

config.cursor_blink_rate = 300
config.cursor_blink_ease_in = "EaseOut"

config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400

config.font = wezterm.font_with_fallback({
	"Maple Mono NF",
	-- "IosevkaTerm Nerd Font Mono"
	-- "VictorMono Nerd Font Mono"
	"Sarasa Term CL",
	"Sarasa Term HC",
	"Sarasa Term J",
	"Sarasa Term K",
	"Sarasa Term SC",
	"Sarasa Term TC",
})
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
config.show_close_tab_button_in_tabs = false
config.show_tab_index_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true
config.use_fancy_tab_bar = false
config.tab_max_width = 64
-- config.hide_tab_bar_if_only_one_tab = true

local function format_directory(path)
	if not path then
		return nil
	end

	-- Remove trailing slashes and split into parts
	local parts = {}
	for part in path:gmatch("[^/\\]+") do
		table.insert(parts, part)
	end

	-- Check for /Users/prayagmatic/ pattern
	if #parts >= 2 and parts[1] == "Users" and parts[2] == "prayagmatic" then
		-- Remove Users/prayagmatic and replace with ~
		table.remove(parts, 1)
		table.remove(parts, 1)
		-- Format remaining path
		if #parts <= 2 then
			return "~/" .. table.concat(parts, "/")
		else
			local formatted = { "~" }
			for i = 1, #parts - 2 do
				table.insert(formatted, parts[i]:sub(1, 1))
			end
			table.insert(formatted, parts[#parts - 1])
			table.insert(formatted, parts[#parts])
			return table.concat(formatted, "/")
		end
	end

	-- Original formatting for other paths
	if #parts <= 2 then
		return table.concat(parts, "/")
	else
		local formatted = {}
		for i = 1, #parts - 2 do
			table.insert(formatted, parts[i]:sub(1, 1))
		end
		table.insert(formatted, parts[#parts - 1])
		table.insert(formatted, parts[#parts])
		return table.concat(formatted, "/")
	end
end

local function get_cwd(tab)
	local cwd = tab.active_pane and tab.active_pane.current_working_dir
	if cwd then
		if cwd.file_path == os.getenv("HOME") .. "/" then
			return "~"
		else
			-- return string.gsub(cwd.file_path, "([/a-zA-Z0-9-_]+)/([a-zA-Z0-9-_]+)/", "%2")
			return format_directory(cwd.file_path)
		end
	end
end

local function format_tab_title(cmdline, path, tab)
	local space_taken_by_tab_index = tab.tab_index + 1 + 3
	local tab_title_max_width = config.tab_max_width - space_taken_by_tab_index
	if #path == 0 then
		if #cmdline <= config.tab_max_width then
			return cmdline
		else
			return cmdline:sub(1, tab_title_max_width - 4 - 3) .. "..."
		end
	end

	local combined = string.format("%s @ %s", cmdline, path)
	if #combined <= tab_title_max_width then
		return combined
	else
		local omission = "..."
		local available_space = tab_title_max_width - #path - 3 - #omission -- 3 for " @ "
		if available_space <= 0 then
			return combined:sub(1, tab_title_max_width)
		end
		return string.format("%s... @ %s", cmdline:sub(1, available_space), path)
	end
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

	local tab_title = ""
	if cmdline == "" then
		tab_title = string.format(" %s: %s ", tab.tab_index + 1, cwd)
	elseif cwd == "~" then
		tab_title = string.format(" %s: %s ", tab.tab_index + 1, format_tab_title(cmdline, "", tab))
	else
		tab_title = string.format(" %s: %s ", tab.tab_index + 1, format_tab_title(cmdline, cwd, tab))
	end

	local cells = {}
	table.insert(cells, { Attribute = { Intensity = "Bold" } })
	table.insert(cells, { Text = tab_title })
	return wezterm.format(cells)
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
		act.SpawnCommandInNewTab({
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
wezterm.on("update-status", function(window, pane)
	local left_cells = {
		{ Background = { Color = colors.foreground } },
	}
	table.insert(left_cells, { Text = string.rep(" ", 2) })
	--
	local domain = wezterm.nerdfonts.oct_terminal
		.. "  "
		.. window:active_pane():get_domain_name()
		.. " "
		.. wezterm.nerdfonts.cod_chevron_right
		.. " "
	table.insert(left_cells, { Background = { Color = colors.foreground } })
	table.insert(left_cells, { Foreground = { Color = colors.background } })
	table.insert(left_cells, { Attribute = { Intensity = "Bold" } })
	table.insert(left_cells, { Text = domain })
	--
	local workspace = " "
		.. wezterm.nerdfonts.cod_window
		.. "  "
		.. window:active_workspace()
		.. " "
		.. wezterm.nerdfonts.cod_chevron_right
		.. " "
	table.insert(left_cells, { Background = { Color = colors.foreground } })
	table.insert(left_cells, { Foreground = { Color = colors.background } })
	table.insert(left_cells, { Attribute = { Intensity = "Bold" } })
	table.insert(left_cells, { Text = workspace })

	window:set_left_status(wezterm.format(left_cells))
	-- window:set_right_status(wezterm.format({
	-- { Foreground = { Color = colors.foreground } },
	-- { Text = "  Current workspace hehe: " },
	-- { Text = window:active_workspace() },
	-- { Text = "  " },
	-- }))
end)

-- config.unix_domains = { { name = "unix" } }
config.default_domain = "local"
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.state_manager.periodic_save({
	interval_seconds = 2 * 60,
	save_workspaces = true,
	save_windows = true,
	save_tabs = true,
})
-- Source: plugin README
-- loads the state whenever I create a new workspace
---@diagnostic disable-next-line: unused-local
wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		resize_window = false,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)
-- Saves the state whenever I select a workspace
---@diagnostic disable-next-line: unused-local
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	local workspace_state = resurrect.workspace_state
	resurrect.state_manager.save_state(workspace_state.get_workspace_state())
	resurrect.state_manager.write_current_state(label, "workspace")
end)
wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, path, label)
	resurrect.state_manager.write_current_state(label, "workspace")
end)
-- resurrect on startup
wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)

---Source: https://github.com/MLFlexer/resurrect.wezterm/issues/73#issuecomment-2798742234
---@param workspace string
---@return MuxWindow
local function get_current_mux_window(workspace)
	for _, mux_win in ipairs(wezterm.mux.all_windows()) do
		if mux_win:get_workspace() == workspace then
			return mux_win
		end
	end
	error("Could not find a workspace with the name: " .. workspace)
end

config.ui_key_cap_rendering = "UnixLong"
-- https://wezfurlong.org/wezterm/config/keys.html?#leader-key
config.leader = { key = "Tab", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "p", mods = "LEADER", action = act.ActivateCommandPalette },
	{ key = "x", mods = "LEADER", action = act.ActivateCopyMode },
	{
		key = " ",
		mods = "LEADER",
		-- Source: https://wezterm.org/config/lua/keyassignment/QuickSelectArgs.html
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			patterns = {
				"https?://\\S+",
			},
			skip_action_on_paste = true,
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				-- wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
	{ key = "y", mods = "LEADER", action = act.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "?", mods = "LEADER", action = act.ShowDebugOverlay },
	{ key = ",", mods = "LEADER", action = act.ReloadConfiguration },

	-- [TODO]: fix shell integration
	-- { key = "P", mods = "LEADER", action = act.ScrollToPrompt(-1) },
	-- { key = "N", mods = "LEADER", action = act.ScrollToPrompt(1) },
	-- { key = "V", mods = "LEADER", action = act.SelectTextAtMouseCursor("SemanticZone") },
	{ key = "u", mods = "LEADER", action = act.ScrollByPage(-0.5) },
	{ key = "d", mods = "LEADER", action = act.ScrollByPage(0.5) },
	{
		key = "e",
		mods = "LEADER",
		action = act.EmitEvent("trigger-vim-with-scrollback"),
	},

	-- session/workspace management
	{ key = "F", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY | WORKSPACES | DOMAINS" }) },
	{
		key = "f",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			---@diagnostic disable-next-line: unused-local
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extention
				if type == "workspace" then
					-- What's happening here,
					-- 1. Select the workspace to switch to from the switcher
					-- 2. Load the selected workspace's state
					local state = resurrect.state_manager.load_state(id, "workspace")
					-- 3. create new workspace with previous name. This is because the
					-- plugin author's intended flow is to restore the selected
					-- workspace's state into the currently running workspace.
					--
					-- What I want is to load the selected workspace while also switching
					-- to that workspace. To achieve that behavior, we create a new
					-- workspace with the same name and then restore the state.
					--
					-- Source: https://github.com/MLFlexer/resurrect.wezterm/issues/73#issuecomment-2572924018
					win:perform_action(
						wezterm.action.SwitchToWorkspace({
							name = state.workspace,
						}),
						pane
					)
					local opts = {
						close_open_tabs = true,
						window = get_current_mux_window(wezterm.mux.get_active_workspace()),
						relative = true,
						restore_text = true,
						resize_window = false,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					}
					resurrect.workspace_state.restore_workspace(state, opts)
				end
			end, { ignore_tabs = true, ignore_windows = true })
		end),
	},
	{
		key = "S",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
			resurrect.tab_state.save_tab_action()
			resurrect.state_manager.write_current_state(wezterm.mux.get_active_workspace(), "workspace")
		end),
	},
	{
		key = "D",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
				resurrect.state_manager.delete_state(id)
			end, {
				title = "Delete State",
				description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
				fuzzy_description = "Search State to Delete: ",
				is_fuzzy = true,
			})
		end),
	},
	{
		key = "s",
		mods = "LEADER",
		action = workspace_switcher.switch_workspace(),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
				end
			end),
		}),
	},
	{
		key = "R",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Text = "Enter new name for workspace" },
			}),
			---@diagnostic disable-next-line: unused-local
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
				end
			end),
		}),
	},
	{ key = "a", mods = "LEADER", action = act.AttachDomain("unix") },
	{ key = "q", mods = "LEADER", action = act.DetachDomain("CurrentPaneDomain") },

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
	{
		key = "r",
		mods = "LEADER",
		action = act.RotatePanes("CounterClockwise"),
	},
	{ key = "o", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "T", mods = "LEADER", action = act.PaneSelect({ mode = "MoveToNewTab" }) },
	{ key = "9", mods = "LEADER", action = act.PaneSelect({ mode = "Activate" }) },
	{ key = "0", mods = "LEADER", action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },
	{
		key = "Q",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		key = ";",
		mods = "CTRL",
		-- action = act.Multiple({
		-- 	-- act.ClearScrollback("ScrollbackAndViewport"),
		-- 	act.SendKey({ key = "L", mods = "CTRL" }),
		-- }),
		action = act.SendKey({ key = "L", mods = "CTRL" }),
	},
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action({ SendString = "\n" }),
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

-- smart splits
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
smart_splits.apply_to_config(config, {
	modifiers = {
		move = "CTRL",
		resize = "CTRL | SHIFT",
	},
})

-- and finally, return the configuration to wezterm
return config
