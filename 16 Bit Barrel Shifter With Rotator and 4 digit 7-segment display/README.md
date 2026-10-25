The objective of this projectb was to design and implement a 16 bit barrel shifter / rotater. 
Pushbuttons were used to control the shift direction, select whether to shift or rotate, and adjust the shift amount. 
Debounce and toggle logic were used to provide stable button inputs, while a clock divider generated slower clock signals for button control and display scanning. 
A 16-bit input value was provided using the switches, and the processed result was displayed on the LEDs and four-digit seven-segment display in hexadecimal.

top_lab7.v - This is the top level module that connects the clock divider, pushbuttons, control modules, shift amount counter, 16 bit barrel shifter, LEDs, and seven segment displays.

toggle_switch.v - This module converts each debounced press of a button into a stored toggle value which lets the button act a control signal of 0 or 1.

debounce.v - This module filters the pushbutton signals so that it registers an output after the input is stable for several clock cycles.

clock_divider_fixed.v - This module divides the 100 Mhz clock into slower clock signals.

barrel_stage.v - This module does one stage of the barrel shifter by shifting or rotating the 16 bit input by a specific amount in either direction.

barrel_shifter16.v - This module combines 4 barrel shifter stages to shift or rotate a 16 bit input by any amount.

shamt_counter.v - This module allows for the shift amount to cycle through larger numbers.

hex_to_7seg.v - This converts a 4 bit hexadecimal value into seven segment display patterns.

seg7_scan8.v - This module scans through the 4 seven segment digits and activates the proper anode and segment pattern.
