----------------------------------------------------
-- Name: Paul Beglin
-- k number: k1889054
-- Project: Project4 Car Key Controller TESTBENCH
----------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Project4_tb is
end entity;
 
architecture simulation of Project4_tb is
 
    -- We are using a low clock frequency to speed up the simulation; again from reference website
    constant ClockHz : integer := 20000; -- //200 KHz
    constant ClkPeriod : time := 1000 ms / ClockHz; --set period like in reference website
 
    signal Clk    : std_logic := '1';
--Outputs
    signal DL 			: std_logic;
    signal DUL			: std_logic;
    signal TRL  		: std_logic;
    signal TRUL   	: std_logic;
	 Signal TRUP   	: std_logic;
	 signal TRDWN 		: std_logic;
	 signal LON,LOFF 	: std_logic;
--Inputs
	 signal key 		: std_logic_vector(3 downto 0);
	 signal TRUNKDIN 	: std_logic;	--To tell us if the user manually put the trunk down 
	 
	 
	 
begin

    UUT: entity work.Project4
    generic map(ClockHz => ClockHz)
    port map (	Clk 		=> Clk,
					DL    	=> DL,
					DUL 		=> DUL,
					TRL		=> TRL,
					TRUL  	=> TRUL,
					TRUP  	=> TRUP,
					TRDWN 	=> TRDWN,
					LON   	=> LON,
					LOFF  	=> LOFF,
					key   	=> key,
					TRUNKDIN	=> TRUNKDIN);
        
    -- Process for generating clock
    Clk <= not Clk after ClkPeriod / 2;
 
    -- Testbench sequence
    process
    begin
		wait until rising_edge(Clk);
		
		--We are on the morning of a trip to the airport, going towards the car.
		wait for 1 sec;
		--We first turn on the lights so we can see better
		key <= "0001";
		wait for 0.5 sec;
		key <= "XXXX";
		wait for 3 sec;
		
		--We then unlock the trunk t<5  and open it manually
		key <= "0010";
		wait for 2 sec;
		key <= "XXXX";
		wait for 2 sec;
		TRUNKDIN <= '0';
		wait for 2 sec;
		
		--After putting our suitcase in, we press BR for t>5 to close the trunk automatically
		key <= "0010";
		wait for 6 sec;
		key <= "XXXX";
		wait for 2 sec;
		
		--We then open the doors to get in the car.
		key <= "0100";
		wait for 1 sec;
		key <= "XXXX";
		

		--DRIVE
		wait for 10 sec;
		
		--Open trunk automatically t>5
		key <= "0010";
		wait for 6 sec;
		key <= "XXXX";
		wait for 1 sec;
		
		--Close trunk manually
		TRUNKDIN <= '1';
		wait for 1 sec;
		
		--Close the doors and turn the lights off
		key <= "1000";
		wait for 1 sec;
		key <= "XXXX";
		wait for 2 sec;
		
		key <= "0001";
		wait for 1 sec;
		key <= "XXXX";
		wait for 3 sec;
 
		wait;
    end process;
 
end architecture;

