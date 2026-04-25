local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local act = wezterm.action

wezterm.on('upload-clipboard-image', function(_, _)
  wezterm.background_child_process {
    '/home/peroyhav/git/dotfiles/bin/upload-clipboard-image-to-ssh',
  }
end)

config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.term = 'wezterm'

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 11.0

config.window_padding = {
  left = 6,
  right = 6,
  top = 6,
  bottom = 6,
}

config.colors = {
  foreground = '#1e1e1e',
  background = '#ffffff',
  cursor_bg = '#1e1e1e',
  cursor_fg = '#ffffff',
  cursor_border = '#1e1e1e',
  selection_fg = '#1e1e1e',
  selection_bg = '#cfe8ff',
  ansi = {
    '#171421',
    '#c01c28',
    '#26a269',
    '#a2734c',
    '#12488b',
    '#a347ba',
    '#2aa1b3',
    '#d0cfcc',
  },
  brights = {
    '#5e5c64',
    '#f66151',
    '#33d17a',
    '#e9ad0c',
    '#2a7bde',
    '#c061cb',
    '#33c7de',
    '#ffffff',
  },
}

config.keys = {
  {
    key = 'I',
    mods = 'CTRL|SHIFT',
    action = act.EmitEvent 'upload-clipboard-image',
  },
}

return config
