----------------------------------------------------
-- Name: Paul Beglin
-- k number: k1889054
-- Project: Project2 submission (ALU with Full adder and multiplier)
----------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 entity Project2 is
    port(A, B: in std_logic_vector(7 downto 0); 
			OpCode: in std_logic_vector(1 downto 0);
         Output: out std_logic_vector(7 downto 0));
end Project2;

architecture TopArch of Project2 is
	signal oSum, oSub, oMult: std_logic_vector(7 downto 0);
	signal Sub: std_logic;
-- SELECTOR
begin
		 Sub <= '0' when OpCode = "00" else
				  '1' when OpCode = "01";
		 addition: entity work.adder8bit port map (A, B, oSum, Sub);
		 product: entity work.Multiplier port map (A(3 downto 0), B(3 downto 0), oMult);
		 Output <= oSum when OpCode = "00" else
					  oSum when OpCode = "01" else	--before it was oSub but I managed to implement both
					  oMult when OpCode = "10" else
					  "ZZZZZZZZ" when OpCode = "11";


end TopArch; 

