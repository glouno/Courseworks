LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity adder8bit is
	port(A, B: in std_logic_vector(7 downto 0);
		  oSum: out std_logic_vector(7 downto 0);
		  Sub: in std_logic);
end adder8bit;

architecture behaviour of adder8bit is
	signal SUM, Cout, realB: std_logic_vector(7 downto 0);
	signal Cin: std_logic;
begin
	LowerSub: Cin <= Sub xor '0';		--careful here we have to use '0' otherwise we will get a type mismatch error
	LowerXorGate: realB(0) <= Sub xor B(0);
	LowerBit: entity work.FullAdder port map (A(0), realB(0), Cin, SUM(0), Cout(0));
	GenerateFullAdder: for I in 1 to 7 generate
		XorGateX: realB(I) <= Sub xor B(i);     --careful i have to change  the full adder port map to "realB()" realB is the input into the FullAdder
		FullAdderX: entity work.FullAdder port map (A(I), realB(I), Cout(I-1), SUM(I), Cout(I));
	end generate GenerateFullAdder;
	
	oSum <= SUM;
end behaviour;