#!/usr/bin/awk -f

BEGIN {
	# CONFIG OPTIONS:

	separator = " | "
	max_title = 16
	max_length = 184
	show_hidden = 1

	# For decorated version:

	color = "a2d1ec" # Blue
	active_window_decoration_style_left_side="%{F#"color"}%{+u}%{u#"color"}"
	active_window_decoration_style_right_side="%{-u}%{F-}"

	# For simple version:

	# active_marker = "#"
	# active_window_decoration_style_left_side="#"
	# active_window_decoration_style_right_side=""

	# CONFIG END

	cmd = "xprop -root _NET_ACTIVE_WINDOW _NET_CURRENT_DESKTOP"

	cmd | getline
	sub("0x", "0x0", $5)
	active_window = $5
	cmd | getline
	current_display = $3
	close(cmd)

	cmd = "wmctrl -lx"

	total_length = 0
	hidden = 0

	while (cmd | getline) {
		if ($2 == current_display) {
			if (total_length != 0)
				printf separator;

			# takes the simple name of the window
			sub(/\..+/, "", $3)

			total_length += length($3) + length(separator)

			if(total_length > max_length) {
				hidden = 1
				while (cmd | getline) hidden++;
				if (show_hidden) {
					printf "%d", hidden;
				}
				break;
			}

			if (length($3) > max_title) {
				$3 = substr($3, 1, max_title)".."
				total_length += 3
			}

			if ($1 == active_window) {
				$3 = active_window_decoration_style_left_side $3 active_window_decoration_style_right_side
				printf "%s", "%{A1:wmctrl -ir '" $1 "' -b toggle,hidden:}" $3 "%{A}"
			} else {
				printf "%s", "%{A1:wmctrl -ia '" $1 "' & disown:}" $3 "%{A}"
			}

		}
	} close(cmd)
}
