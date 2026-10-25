The objective of this project was to use a 32 bit clock divider and a 32 to 1 multiplexer to allow the counting speed to be adjusted using switches. 
Two BCD counters generate a ones and tens digit. 
These digits can count up or down independently depending on switches and the value of the number is represented by the LEDs. 
An ALU module adds or subtracts these counter values and the results are displayed on a seven segment display.

top_lab6.v - This module integrates everything together, the clock divider, BCD counters, ALU, and seven segment displays so that the lab functions as a counter and arithmetic system controlled by switches.

debounce.v - Filters the reset and direction pushbuttons to create a stable signal.

clock_divider.v - Uses the 100 Mhz board clock to generate a 32 bit counter whose individual bits provide.

mux32x1.v - Uses the input switches SW [4:0] to select one of the 32 counter bits and determine the counting speed.

bcd_counter.v - This module is a BCD counter that counts up or down based on the direction input and generates a rollover signal whenever the count wraps around.

seg7_three_digit.v - This module switches between the ALU ones digit, ALU tens digit, and control nibble to display all three values using one shared seven-segment output.
