local wezterm = require("wezterm")
local action = wezterm.action

local function font_with_fallback(name, params)
  local names = { name, "Apple Color Emoji", "azuki_font" }
  return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrainsMono Nerd Font"

return {
  automatically_reload_config = true,
  color_scheme = "Gruvbox Dark",
  disable_default_key_bindings = true,
  font = font_with_fallback(font_name),
  font_rules = {
    { italic = true, font = font_with_fallback(font_name, { italic = true }) },
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback(font_name, { bold = true, italic = true }),
    },
    {
      intensity = "Bold",
      font = font_with_fallback(font_name, { bold = true }),
    },
  },
  font_size = 15,
  keys = {
    {
      key = "d",
      mods = "CTRL",
      action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
    },
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.Copy },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.Paste },
    { key = "w", mods = "CTRL", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
    { key = "d", mods = "CTRL|SHIFT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
    { key = "h", mods = "LEADER", action = action({ ActivatePaneDirection = "Left" }) },
    { key = "l", mods = "LEADER", action = action({ ActivatePaneDirection = "Right" }) },
    { key = "k", mods = "LEADER", action = action({ ActivatePaneDirection = "Up" }) },
    { key = "j", mods = "LEADER", action = action({ ActivatePaneDirection = "Down" }) },
    { key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "DefaultDomain" }) },
    { key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
    { key = "o", mods = "LEADER", action = "ActivateLastTab" },
    { key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
  },
  leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
  line_height = 1.0,
  window_background_opacity = 0.9,
}
