top_lab5.v - Connects all of the modules together and maps the board’s clock, switches, buttons, LEDs, and seven segment display to the appropriate signals.

debounce.v - Filters the reset and direction pushbuttons to create a stable signal.

clock_divider.v - Uses the 100 Mhz board clock to generate a 32 bit counter whose individual bits provide.

mux32x1.v - Uses the input switches SW [4:0] to select one of the 32 counter bits and determine the counting speed.

bcd_up_down_counter.v - Counts a single decimal digit from 0 to 9 in either direction and accounts for a rollover when the digit wraps around.

seg7_scan.v - Multiplexes the one and tens digits and converts each into decimal values into the seven segment display patterns.
