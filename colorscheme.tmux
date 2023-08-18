#!/usr/bin/env bash

plugin_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

colorscheme_option="@tmux-colorscheme"
colorscheme_option_default="kanagawa"

get_option() {
  local option="$1"
  local default_value="$2"
  local option_value
  option_value=$(tmux show-option -gqv "${option}")
  if [ -z "${option_value}" ]; then
    echo "${default_value}"
  else
    echo "${option_value}"
  fi
}

get() {
  local option=$1
  local default_value=$2
  local value
  value="$(tmux show -gqv "${option}")"
  [ -n "${value}" ] && echo "${value}" || echo "${default_value}"
}

set() {
  local option=$1
  local value=$2
  tmux_commands+=(set-option -gq "${option}" "${value}" ";")
}

setw() {
  local option=$1
  local value=$2
  tmux_commands+=(set-window-option -gq "${option}" "${value}" ";")
}

set_status_bar() {
  local show_upload_speed
  local show_download_speed
  local show_prefix_highlight
  local show_battery
  local status_bar

  show_upload_speed="$(get '@tmux-colorscheme-show-upload-speed' false)"
  show_download_speed="$(get '@tmux-colorscheme-show-download-speed' false)"
  show_prefix_highlight="$(get '@tmux-colorscheme-show-prefix-highlight' false)"
  show_battery="$(get '@tmux-colorscheme-show-battery' false)"
  show_pomodoro="$(get '@tmux-colorscheme-show-pomodoro' false)"

  status_bar="#[bg=${theme_bg},fg=${theme_fg}] 󰃭 %Y-%m-%d %H:%M #[bg=${theme_bg}]"
  if "${show_prefix_highlight}"; then
    status_bar="#{prefix_highlight}${status_bar}"
  fi
  if "${show_pomodoro}"; then
    status_bar="${status_bar} #[bg=${theme_bg},fg=${theme_gray}]#{pomodoro_status}"
  fi
  if "${show_download_speed}"; then
    status_bar="${status_bar} #[bg=${theme_bg},fg=${theme_cyan}]󰅢 #{download_speed}"
  fi
  if "${show_upload_speed}"; then
    status_bar="${status_bar} #[bg=${theme_bg},fg=${theme_blue}]󰅧 #{upload_speed}"
  fi
  if "${show_battery}"; then
    status_bar="${status_bar} #[bg=${theme_bg},fg=${theme_green}]#{battery_icon_charge} #{battery_percentage}"
  fi

  set status-left ""
  set status-right "${status_bar}"
}

main() {
  local colorscheme
  colorscheme=$(get_option "${colorscheme_option}" "${colorscheme_option_default}")

  # Aggregate all commands in one array
  local tmux_commands=()

  # NOTE: Pulling in the selected theme by the theme that's being set as local
  # variables.
  # shellcheck source=catppuccin-frappe.tmuxtheme
  source /dev/stdin <<<"$(sed -e "/^[^#].*=/s/^/local /" "${plugin_dir}/${colorscheme}.tmuxtheme")"

  set status "on"
  set status-justify "left"
  set status-left-length "100"
  set status-right-length "100"

  # Default statusbar color
  set status-style "bg=${theme_bg},fg=${theme_fg}"

  # Pane border
  set pane-active-border-style "fg=${theme_accent}"
  set pane-border-style "fg=${theme_gray}"

  # Tmux message displayed (e.g. "Reloaded")
  set message-style "bg=${theme_bg},fg=${theme_accent}"

  # Clock (`prefix + t`)
  setw clock-mode-colour "${theme_accent}"

  set_status_bar

  # Window
  setw window-status-current-format "#[bg=${theme_accent},fg=${theme_black},bold] #I #W#{?window_zoomed_flag,*Z,} "
  setw window-status-format "#[bg=${theme_bg},fg=${theme_fg}] #I #W "

  # Prefix color scheme
  set @prefix_highlight_bg "${theme_accent}"
  set @prefix_highlight_fg "${theme_black}"
  set @prefix_highlight_copy_mode_attr "bg=${theme_accent},fg=${theme_black}"
  set @prefix_highlight_show_copy_mode 'on'
  set @prefix_highlight_output_prefix ''
  set @prefix_highlight_output_suffix ''

  tmux "${tmux_commands[@]}"
}

main "$@"
