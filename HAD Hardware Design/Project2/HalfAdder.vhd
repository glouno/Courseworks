LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity HalfAdder is
	port(A, B: in std_logic; 
		  SUM, Cout: out std_logic);
end HalfAdder;

architecture structural of HalfAdder is
	--signal A, B: std_logic;
begin
	process(A, B)
	begin
		SUM <= A xor B;
		Cout <= A and B;
	end process;
end structural;