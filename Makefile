# If using awka, you can compile polybar-windows.awk
# into binary polybar-windows

# THIS IS COMPLETELY OPTIONAL

.PHONY: all

AWKA := awka
CC := gcc
C_FLAGS := -Wall -march=native -O3 -DNDEBUG -s
C_LIBS := -lawka

all: polybar-windows

polybar-windows: polybar-windows.awk
	$(AWKA) -f polybar-windows.awk > polybar-windows.c
	$(CC) $(C_FLAGS) -o polybar-windows polybar-windows.c -lawka

