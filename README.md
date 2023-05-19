# Gruvbox color theme configuration for Tmux

Theme with 'retro groove' flavor for [Tmux](https://github.com/tmux/tmux), based on Pavel Pertsev's [Gruvbox colorscheme](https://github.com/morhetz/gruvbox).

## Installation
### Install manually

1. Copy your desired theme's configuration contents into your Tmux config (usually stored at ~/.tmux.conf)
1. Reload Tmux by either restarting the session or reloading it with tmux source-file ~/.tmux.conf

### Install through [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add plugin to the list of TPM plugins in `.tmux.conf` and select desired theme

```bash
set -g @plugin 'l-lin/tmux-gruvbox'
set -g @tmux-gruvbox 'dark' # or 'light'
```

Hit `prefix + I` to fetch the plugin and source it. Your Tmux should be updated with the theme at this point.

## Background
### Dark (default)

```tmux
set -g @plugin-gruvbox-background 'dark'
```

![gruvbox dark](./gruvbox-dark.png)

### Light (default)

```tmux
set -g @plugin-gruvbox-background 'light'
```

![gruvbox light](./gruvbox-light.png)

## Plugin support
### [tmux-netspeed](https://github.com/wfxr/tmux-net-speed)

```tmux
set -g @tmux-gruvbox-show-upload-speed true
set -g @tmux-gruvbox-show-download-speed true
```

### [tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight)

```tmux
set -g @tmux-gruvbox-show-prefix-highlight true
```

### [tmux-plugins/tmux-battery](https://github.com/tmux-plugins/tmux-battery)

```tmux
set -g @tmux-gruvbox-show-battery true
```

