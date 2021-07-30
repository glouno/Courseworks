----------------------------------------------------
-- Name: Paul Beglin
-- k number: k1889054
-- Project: Project1 submission (Full adder and encoder)
----------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 entity Project1 is
    port(i: in std_logic_vector(3 downto 0); 
			SEL: in std_logic;
         o: out std_logic_vector(1 downto 0));
end Project1;
 
architecture arch of Project1 is


-- SELECTOR
begin
	process(SEL, i)
	begin 
		 if (SEL = '0') then -- Full Adder
			  o(0) <= i(2) xor (i(0) xor i(1));
			  o(1) <= (i(0) and i(1)) or (i(0) and i(2)) or (i(1) and i(2));
		 end if;

		 if SEL ='1' then
			  -- 4 to 2 Encoder
			  case i is
				when "0001" => o <= "00";
				when "0010" => o <= "01";
				when "0100" => o <= "10";
				when "1000" => o <= "11";
				when others => o <= "ZZ";
			  end case;

		 end if;
end process;

end arch;