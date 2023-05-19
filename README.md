# Gruvbox color theme configuration for Tmux

Theme with 'retro groove' flavor for [Tmux][github-tmux], based on Pavel Pertsev's [Gruvbox colorscheme][github-gruvbox].

| Dark theme | Light theme |
|---|---|

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

[github-tmux]: https://github.com/tmux/tmux
[github-grovbox]: https://github.com/morhetz/gruvbox

