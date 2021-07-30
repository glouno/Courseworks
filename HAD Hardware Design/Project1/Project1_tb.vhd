----------------------------------------------------
-- Name: Paul Beglin
-- k number: k1889054
-- Project: Project1 submission (Full adder and encoder)
-- Test Bench
----------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Project1_tb IS
END Project1_tb;
 
architecture arch of Project1_tb is

 
--Inputs
signal i : std_logic_vector(3 downto 0);
signal SEL : std_logic;
 
--Outputs
signal o : std_logic_vector(1 downto 0);
 
BEGIN
 UUT: entity work.Project1 port map(i,SEL,o);


 process
begin
 -- hold reset state for 200 ns.
 
wait for 200 ns;
 SEL <= '1';
i <= "0000";
 
wait for 50 ns;
 
i <= "0001";
 
wait for 50 ns;
 
i <= "0010";
 
wait for 50 ns;
 
i <= "0100";
 
wait for 50 ns;
 
i <= "1000";
wait for 50 ns;
 
i <= "1100"; --output should be ZZ test case



wait for 200 ns;
SEL <= '0';
i <= "0000";
 
wait for 50 ns;

i <= "0001";
 
wait for 50 ns;
 
i <= "0010";
 
wait for 50 ns;
 
i <= "0011";
 
wait for 50 ns;
 
i <= "0100";
wait for 50 ns;
 
i <= "0101";
 
wait for 50 ns;
 
i <= "0110";
 
wait for 50 ns;
 
i <= "0111";

wait for 50 ns;
 
wait;
end process;
 
END;