----------------------------------------------------
-- Name: Paul Beglin
-- k number: k1889054
-- Project: Project4 Car key Controller FSM
----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Project4 is
generic(ClockHz : integer :=1); -- 200MHz 200000000

    port(Clk: in std_logic;
    
    DL  		: out std_logic;
	 DUL    	: out std_logic;
    TRL  	: out std_logic;
    TRUL  	: out std_logic;
	 TRUP  	: out std_logic;
	 TRDWN   : out std_logic;
    LON  	: out std_logic;
    LOFF 	: out std_logic;
	 
	 key 		: in std_logic_vector(3 downto 0); --easier than having 4 separate variables
	 
	 -- Input sensors
	 TRUNKDIN 	: in std_logic);	--inout didn't work for some reason so we're using a separate input from the signal that describes the trunk sensor
											-- So that we can say in the test bench if we closed the trunk manually for example
			
end Project4;


architecture arch of Project4 is

-- Enumerated type declaration and state signal declaration, from reference website

	type state_type is (trunk_locking,trunk_unlocking,doors_locking,doors_unlocking,lighton,lightoff,all_idle);
	signal counter : integer range 0 to clockhz * 60;
	signal state: 		state_type:=all_idle; -- initial state
	 
	type keypress_type is (TL,TR,BR,BL,NONE);
	signal keypress : keypress_type := NONE;
	
	--More stuff
	signal TRUNKD		: 	std_logic	:='1'; --Trunk position down 
	signal LIGHT		: 	std_logic 	:='0'; --LIGHT sensor is here
	signal TRUNKLOCK	: 	std_logic	:='1'; --signal helping us deal with the logic behind trunk behaviour
	signal TRUNKDPREV :	std_logic	:='1'; --Helping us with the TRUNKDIN input


begin
	
	process(Clk, TRUNKD) is
	begin
		if rising_edge(Clk) then
		
			if TRUNKDPREV /= TRUNKDIN and TRUNKDIN /= 'U'  then
				TRUNKD <= TRUNKDIN;
			end if;
	
			--Key inputs
			if key = "0000" then
			keypress<= NONE;
			elsif key = "0001" then
			keypress <= BL;
			elsif key = "0010" then
			keypress <= BR;
			elsif key = "0100" then
			keypress <= TR;
			elsif key = "1000" then
			keypress <= TL;
			elsif key = "XXXX" then
			keypress <= NONE;
			end if;
			-- Goes in a clockwise rotation if we visualise the keys: TL->TR->BR->BL
	
			
			
			case state is
			
				--The doors
				when doors_locking =>						-- This is only used to set the values of DL and DUL, the logic is done in the idle state
					if keypress = NONE then
						DL <= '1';
						DUL<= '0';
						state <= all_idle;
					end if;
				
				when doors_unlocking =>					-- This is only used to set the values of DL and DUL, the logic is done in the idle state
					if keypress = NONE then
						DL <= '0';
						DUL<= '1';
						state <= all_idle;
					end if;
				
				
				--The lights
				when lighton =>						-- This is only used to set the values of LON and LOFF the logic is done in the idle state
					if keypress = NONE then
						LON  <= '1';
						LOFF <= '0';
						LIGHT<= '1';
						state <= all_idle;
					end if;
				
				when lightoff =>						-- This is only used to set the values of LON and LOFF, the logic is done in the idle state
					if keypress = NONE then
						LON  <= '0';
						LOFF <= '1';
						LIGHT<= '0';
						state <= all_idle;
					end if;
				
				
				--The trunk
				when trunk_locking =>						-- From idle we want to lock the trunk 
				
					counter <= counter + 1; --Keep track of time spent to change the behaviour based on the time the button is pressed
				
					if keypress = NONE then
						if counter >= ClockHz * 5 - 1 and TRUNKD = '0' then --trunk is up and t>5

								TRL	<= '1';
								TRUL	<= '0'; 
								TRUP	<= '0';
								TRDWN	<= '1';
								TRUNKD<= '1';
								TRUNKLOCK<= '1';
								state <= all_idle; --trunk goes down (locked)
							
							
						else --t<5
							if TRUNKD = '1' then --trunk is down (unlocked) and t<5
							
								TRL	<= '1';
								TRUL	<= '0'; 
								TRUP	<= '0';
								TRDWN	<= '1';
								TRUNKD<= '1';
								TRUNKLOCK<= '1';
								state <= all_idle; --trunk stays down, becomes locked
								
							elsif TRUNKD = '0' then --trunk is UP and t<5 SPECIAL CASE 
								state <= all_idle; --SPECIAL CASE, do nothing
							end if;
						end if;
					end if;
				
			
				
				
				when trunk_unlocking =>						-- From idle we want to unlock the trunk 
				
					counter <= counter + 1; --Keep track of time spent to change the behaviour based on the time the button is pressed
				
					if keypress = NONE then
						if counter >= ClockHz * 5 - 1 then --t>5
							if TRUNKD = '1' then --trunk is down and t>5
							
								TRL	<= '0';
								TRUL	<= '1'; 
								TRUP	<= '1';
								TRDWN	<= '0';
								TRUNKD<= '0';
								TRUNKLOCK<= '0';
								state <= all_idle; --trunk goes up (unlocked)
								
							end if;
							
							
						else --t<5
							if TRUNKD = '1' then --trunk is down (locked) and t<5
							
								TRL	<= '0';
								TRUL	<= '1'; 
								TRUP	<= '0';
								TRDWN	<= '1';
								TRUNKD<= '1';
								TRUNKLOCK<= '0';
								state <= all_idle; --trunk stays down (unlocked)
								
							end if;
						end if;
					end if;
				
				
				--General all_idle state
				when all_idle =>
					DL 	<= 'X';						-- The instructions are to leave the outputs on for one cycle, and then put them back to the inactive state
					DUL	<= 'X';
					TRL	<= 'X';
					TRUL 	<= 'X';
					TRUP 	<= 'X';
					TRDWN	<= 'X';
					LON	<= 'X';
					LOFF	<= 'X';
					
					--Special TRUNKD values
					if TRUNKD /= TRUNKDPREV then
						if TRUNKD = '1' then
							TRUP <= '0';
							TRDWN <= '1';
						elsif TRUNKD = '0' then
							TRUP <= '1';
							TRDWN <= '0';
						end if;
						TRUNKDPREV <= TRUNKD;
					end if;
				
					
						--The Doors
					if keypress = TL then			--locks the door
						state <= doors_locking;     
					elsif keypress = TR then		--unlocks the door
						state <= doors_unlocking;
					
					
						--The lights
					elsif keypress = BL and LIGHT = '0' then		--lights are off and button is pressed so we turn them on
						state <= lighton;     
					elsif keypress = BL and LIGHT = '1' then		--light sensor is on ...
						state <= lightoff; 
						
						
						--The trunk
					elsif keypress = BR and TRUNKLOCK = '0' then		--trunk is unlocked so we try to unlock it (further logic in the trunk section)
						counter <= 1;
						state <= trunk_locking;     
					elsif keypress = BR and TRUNKLOCK = '1' then		--trunk is locked so we try to unlock it
						counter <= 1;
						state <= trunk_unlocking; 
					
					
					end if;
					
					
			end case;
			
	
		end if;
	end process;

end arch;
