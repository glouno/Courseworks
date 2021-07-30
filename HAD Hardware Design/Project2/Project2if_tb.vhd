----------------------------------------------------
-- Name: Paul Beglin
-- k number: k1889054
-- Project: Project2 submission (ALU with Full adder and multiplier)
-- Test Bench
----------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity Project2_tb is
end Project2_tb;

architecture arch of Project2_tb is

 
--Inputs
signal A, B : std_logic_vector(7 downto 0);
signal OpCode : std_logic_vector(1 downto 0);
 
--Outputs
signal Output : std_logic_vector(7 downto 0);
 
BEGIN
 UUT: entity work.Project2 port map(A, B, OpCode, Output);


 process
begin
 -- hold reset state for 200 ns.
 
 
----- TESTING ADDITION ------ 

wait for 200 ns;
 OpCode <= "00";

A <= "00010000";
B <= "00001000";
 
wait for 50 ns;
 
A <= "00010000";
B <= "00011000";
 
wait for 50 ns;
 
A <= "11000000"; --overflow case
B <= "10100000";
 
wait for 50 ns;
 
A <= "00000000";
B <= "00000001";
 
wait for 50 ns;



------ TESTING SUBSTRACTION -------

wait for 200 ns;
OpCode <= "01";

A <= "00010000";
B <= "00001000";
 
wait for 50 ns;

A <= "00011000";
B <= "00001000";
 
wait for 50 ns;
 
A <= "00001000";
B <= "00001000";
 
wait for 50 ns;
 
A <= "01010010";
B <= "01001001";
 
wait for 50 ns;



------ TESTING MULtiplier -------

wait for 200 ns;
OpCode <= "10";

A <= "00000111";
B <= "00000011";
 
wait for 50 ns;

A <= "00000100";
B <= "00000100";
 
wait for 50 ns;
 
A <= "00000001";
B <= "00000010";
 
wait for 50 ns;
 
A <= "00000000";
B <= "00000000";

wait for 50 ns;

wait;
end process;
 
END;