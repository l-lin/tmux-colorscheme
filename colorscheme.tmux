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
  local show_cpu
  local show_cpu_temp
  local show_ram
  local show_pomodoro
  local status_bar

  show_upload_speed="$(get '@tmux-colorscheme-show-upload-speed' false)"
  show_download_speed="$(get '@tmux-colorscheme-show-download-speed' false)"
  show_prefix_highlight="$(get '@tmux-colorscheme-show-prefix-highlight' false)"
  show_battery="$(get '@tmux-colorscheme-show-battery' false)"
  show_cpu="$(get '@tmux-colorscheme-show-cpu' false)"
  show_cpu_temp="$(get '@tmux-colorscheme-show-cpu-temp' false)"
  show_ram="$(get '@tmux-colorscheme-show-ram' false)"
  show_pomodoro="$(get '@tmux-colorscheme-show-pomodoro' false)"

  if "${show_prefix_highlight}"; then
    status_bar="#{prefix_highlight}${status_bar}"
  fi
  if "${show_pomodoro}"; then
    status_bar="${status_bar} #[bg=${theme_bg},fg=${theme_blue}]#{pomodoro_status}"
  fi
  if "${show_download_speed}"; then
    status_bar="${status_bar} #[bg=${theme_bg},fg=${theme_fg}]󰅢 #{download_speed}"
  fi
  if "${show_upload_speed}"; then
    status_bar="${status_bar} #[bg=${theme_bg},fg=${theme_fg}]󰅧 #{upload_speed}"
  fi
  if "${show_ram}"; then
    set @ram_low_fg_color "#[bg=${theme_bg},fg=${theme_fg}]"
    set @ram_medium_fg_color "#[bg=${theme_bg},fg=${theme_yellow}]"
    set @ram_high_fg_color "#[bg=${theme_bg},fg=${theme_red}]"
    status_bar="${status_bar} #{ram_fg_color} ̛̛̛ #{ram_percentage}"
  fi
  if "${show_cpu}"; then
    set @cpu_low_fg_color "#[bg=${theme_bg},fg=${theme_fg}]"
    set @cpu_medium_fg_color "#[bg=${theme_bg},fg=${theme_yellow}]"
    set @cpu_high_fg_color "#[bg=${theme_bg},fg=${theme_red}]"
    status_bar="${status_bar} #{cpu_fg_color}  #{cpu_percentage}"
  fi
  if "${show_cpu_temp}"; then
    set @cpu_temp_low_fg_color "#[bg=${theme_bg},fg=${theme_fg}]"
    set @cpu_temp_medium_fg_color "#[bg=${theme_bg},fg=${theme_yellow}]"
    set @cpu_temp_high_fg_color "#[bg=${theme_bg},fg=${theme_red}]"
    status_bar="${status_bar} #{cpu_temp_fg_color} #{cpu_temp}"
  fi
  status_bar="${status_bar} #[bg=${theme_bg},fg=${theme_fg}] 󰃭 %Y-%m-%d %H:%M #[bg=${theme_bg}]"
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

  # NOTE: Pulling in the selected theme by the theme that's being set as local variables.
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
  setw window-status-current-format "#[bg=${theme_accent_bg},fg=${theme_accent_fg}] #I #W#{?window_zoomed_flag,*Z,} "
  setw window-status-format "#[bg=${theme_bg},fg=${theme_fg}] #I #W "

  # Prefix color scheme
  set @prefix_highlight_bg "${theme_accent_bg}"
  set @prefix_highlight_fg "${theme_accent_fg}"
  set @prefix_highlight_copy_mode_attr "bg=${theme_accent_bg},fg=${theme_accent_fg}"
  set @prefix_highlight_show_copy_mode 'on'
  set @prefix_highlight_output_prefix ''
  set @prefix_highlight_output_suffix ''

  # Set the mode style (copy mode)
  set mode-style "bg=${theme_accent_bg},fg=${theme_accent_fg}"
  # Set the style for search
  set copy-mode-match-style "bg=${theme_search_match_bg},fg=${theme_search_match_fg}"
  set copy-mode-current-match-style "bg=${theme_search_match_bg},fg=${theme_search_match_fg} bold"

  tmux "${tmux_commands[@]}"
}

main "$@"
