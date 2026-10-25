This lab uses a Pulse Width Modulation (PWM) controller for the RGB LED on the Nexys A7 FPGA. 
There are eight switch inputs and a load button, where the user stores an 8 bit value for the PWM resolution, red duty cycle, green duty cycle, and blue duty cycle. 

The stored values are synchronized into the PWM clock domain and used by the PWM core to generate PWM signals for each color channel. 
By varying the duty cycle of each channel, the system controls the brightness of the red, green, and blue LEDs which allows for different colors and brightnesses to be chosen and displayed. 

What is RES (Resolution)?
The RES (resolution) register stores the PWM period. 
This value determines the number of counts in each PWM cycle and is the range of available duty-cycle values. 
A larger resolution provides finer brightness control for the RGB LED channels.

For example, a resolution of 255 allows the duty cycle to be adjusted for 256 brightness levels

What is 4 Slot Loading?
The four slot loading represents how each press of the load button stores the current 8-bit switch value into one of four registers of RES (resolution), red, green, and blue.  
For example, the user can load a resolution of 255, a red value of 255, a green value of 0, and a blue value of 0 to produce a bright red output. 
The slot that the user is currently filling out is represented by the LED under the switches.

top_lab8.v - The top_lab8 module serves as the top-level controller, and connects all submodules to load PWM settings from the switches and generate the RGB LED output.

debounce_onepulse.v - This module filters the pushbutton signals so that it registers an output after the input is stable for several clock cycles.

clock_divider_fixed.v - This module divides the 100 Mhz clock into slower clock signals.

load_fsm.v - This module does one stage of the barrel shifter by shifting or rotating the 16 bit input by a specific amount in either direction.

pwm_core.v - This module combines 4 barrel shifter stages to shift or rotate a 16 bit input by any amount.

rgb_led_driver.v - This module allows for the shift amount to cycle through larger numbers.
