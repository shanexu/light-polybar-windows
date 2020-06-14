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

	cmd = "wmctrl -lx"
}

function update_list()
{
	total_length = 0
	num_hidden = 0

	while ((cmd | getline) > 0) {
		if ($2 == current_display) {
			if (total_length != 0) {
				printf separator;
				total_length += length(separator)
			}

			# takes the simple name of the window
			sub(/\..+/, "", $3)

			if (length($3) > max_title) {
				$3 = substr($3, 1, max_title)".."
				total_length += max_title + 2
			} else {
				total_length += length($3)
			}

			if (total_length > max_length) {
				do ++num_hidden;
				while (cmd | getline _)

				if (show_hidden)
					printf "%d", num_hidden;

				break;
			}

			# right-click closes (normally) the window
			$3 = "%{A3:wmctrl -ic '" $1 "':}" $3 "%{A}"

			if ($1 == active_window) {
				# makes the window decorated and minimizable by left-clicking
				$3 = active_window_decoration_style_left_side $3 active_window_decoration_style_right_side
				printf "%s", "%{A1:wmctrl -ir '" $1 "' -b toggle,hidden:}" $3 "%{A}"
			} else {
				# makes the window activable by left-clicking
				printf "%s", "%{A1:wmctrl -ia '" $1 "':}" $3 "%{A}"
			}
		}
	} close(cmd)

	printf "\n"
	fflush(stdout)
}

$1 == "_NET_CURRENT_DESKTOP" {
	current_display = $3
	update_list()
}

$1 == "_NET_ACTIVE_WINDOW:" && ($5 != "0x0") {
	# makes $5 long at least 10 characters if it is not already
	if (length($5) < 10)
		$5 = sprintf("0x%0" (10 - length($5)) "d%s", 0, substr($5, 3))

	active_window = $5
	update_list()
}

$1 == "_NET_CURRENT_DESKTOP:" {
	update_list()
}
