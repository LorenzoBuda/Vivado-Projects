In this project a 16-to-1 multiplexer was designed using gate-level 2x1 multiplexers in Verilog. 
The MUX is controlled using the pushbuttons on the Nexys A7 board, which must behave like switches using toggle logic. 
This requires implementing a debouncing system and a toggle flip-flop for each select bit. 
The output of the multiplexer will be shown on LED0, while the inputs will be fed from the 16 switches (SW[15:0]).
