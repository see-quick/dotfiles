local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  default_cursor_style = "BlinkingBar",
  color_scheme = "Nord (Gogh)",
  font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
  font_size = 12.5,
  background = {
    {
      source = {
        File = "/Users/morsak/Downloads/macos-monterey.jpg"
      },
      hsb = {
        hue = 1.0,
        saturation = 1.02,
        brightness = 0.25,
      },
      width = "100%",
      height = "100%",
    },
    {
      source = {
        Color = "#282c35",
      },
      width = "100%",
      height = "100%",
      opacity = 0.55,
    },
  },
  -- Keybindings for splitting screen
  keys = {
    -- Split horizontally (Command + D)
    {
      key = "D",
      mods = "CMD",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    -- Split vertically (Command + E)
    {
      key = "E",
      mods = "CMD",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
     -- Pane navigation (SHIFT + CMD + Arrow keys)
    {
      key = "LeftArrow",
      mods = "SHIFT|CMD",
      action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
      key = "RightArrow",
      mods = "SHIFT|CMD",
      action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
      key = "UpArrow",
      mods = "SHIFT|CMD",
      action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
      key = "DownArrow",
      mods = "SHIFT|CMD",
      action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
    -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
      key = 'LeftArrow',
      mods = 'OPT',
      action = wezterm.action.SendKey {
      key = 'b',
      mods = 'ALT',
      },
    },
    {
      key = 'RightArrow',
      mods = 'OPT',
      action = wezterm.action.SendKey { key = 'f', mods = 'ALT' },
    },
  },
  -- from: https://akos.ma/blog/adopting-wezterm/
  hyperlink_rules = {
    -- Matches: a URL in parens: (URL)
    {
      regex = "\\((\\w+://\\S+)\\)",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in brackets: [URL]
    {
      regex = "\\[(\\w+://\\S+)\\]",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in curly braces: {URL}
    {
      regex = "\\{(\\w+://\\S+)\\}",
      format = "$1",
      highlight = 1,
    },
    -- Matches: a URL in angle brackets: <URL>
    {
      regex = "<(\\w+://\\S+)>",
      format = "$1",
      highlight = 1,
    },
    -- Then handle URLs not wrapped in brackets
    {
      -- Before
      --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
      --format = '$0',
      -- After
      regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
      format = "$1",
      highlight = 1,
    },
    -- implicit mailto link
    {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
    },
  },
}

return config
