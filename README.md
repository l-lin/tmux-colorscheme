# Colorscheme theme configuration for Tmux


## Installation
### Install manually

1. Copy your desired theme's configuration contents into your Tmux config (usually stored at ~/.tmux.conf)
1. Reload Tmux by either restarting the session or reloading it with tmux source-file ~/.tmux.conf

### Install through [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add plugin to the list of TPM plugins in `.tmux.conf` and select desired theme

```bash
set -g @plugin 'l-lin/tmux-colorscheme'
set -g @tmux-colorscheme 'kanagawa' # or 'gruvbox-dark' or 'gruvbox-light' or 'github-light'

# You can also add your own colorscheme by putting in ${XDG_DATA_HOME}/tmux/tmux-colorscheme/my-colorscheme.tmuxtheme
set -g @tmux-colorscheme 'my-colorscheme'
```

Hit `prefix + I` to fetch the plugin and source it. Your Tmux should be updated with the theme at this point.

## Kanagawa

Dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai, based on https://github.com/rebelot/kanagawa.nvim.

```tmux
set -g @plugin-colorscheme 'kanagawa'
```

## Github
### Light

Github light colorscheme.

```tmux
set -g @plugin-colorscheme 'github-light'
```

## Gruvbox

Theme with 'retro groove' flavor for [Tmux](https://github.com/tmux/tmux), based on Pavel Pertsev's [Gruvbox colorscheme](https://github.com/morhetz/gruvbox).

### Dark

```tmux
set -g @plugin-colorscheme 'gruvbox-dark'
```

![gruvbox dark](./gruvbox-dark.png)

### Light

```tmux
set -g @plugin-gruvbox 'gruvbox-light'
```

![gruvbox light](./gruvbox-light.png)

## Plugin support
### [tmux-netspeed](https://github.com/wfxr/tmux-net-speed)

```tmux
set -g @tmux-colorscheme-show-upload-speed true
set -g @tmux-colorscheme-show-download-speed true
```

### [tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight)

```tmux
set -g @tmux-colorscheme-show-prefix-highlight true
```

### [tmux-plugins/tmux-battery](https://github.com/tmux-plugins/tmux-battery)

```tmux
set -g @tmux-colorscheme-show-battery true
```

### [tmux-pomodoro-plus](https://github.com/olimorris/tmux-pomodoro-plus)

```tmux
set -g @tmux-colorscheme-show-pomodoro true
```

### [tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)

```
set -g @tmux-colorscheme-show-cpu true
set -g @tmux-colorscheme-show-cpu-temp true
set -g @tmux-colorscheme-show-ram true
```

### date

```
set -g @tmux-colorscheme-show-date true
```
