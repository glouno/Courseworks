LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity FullAdder is
	port(A, B, Cin: in std_logic; 
		  SUM, Cout: out std_logic);
end FullAdder;

architecture structural of FullAdder is
	--signal A, B: std_logic;
begin
	process(A, B, Cin)
	begin
		SUM <= Cin xor (A xor B);
		Cout <= (A and B) or (B and Cin) or (A and Cin);
	end process;
end structural;