local config = wezterm.config_builder()

config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.text_background_opacity = 1.0
config.window_background_opacity = 0.97
config.color_scheme = "Darcula (base16)"
return config
