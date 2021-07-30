LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
entity Multiplier is
	port(A, B: in std_logic_vector(3 downto 0);
		  oMult: out std_logic_vector(7 downto 0));
end Multiplier;

-------- HERE WE WILL TRY TO GENERATE WITH TWO FOR LOOPS --------
architecture behaviour of Multiplier is
	signal c1, c2, c3: std_logic_vector(3 downto 0);
	signal sum1, sum2, sum3: std_logic_vector(3 downto 0);
	
	type twodimarray is array (0 to 3, 0 to 3) of std_logic; -- create 4x4 array to store andgate inputs
	signal  andgates : twodimarray;
	
begin	
	GenerateA: for I in 0 to 3 generate			--B(I)
		GenerateB: for J in 0 to 3 generate		--A(J)
			andgates(J,I) <= A(J) and B(I);					--2D array with all the andgates
		end generate GenerateB;
	end generate GenerateA;
	
	HA0: entity work.HalfAdder port map (andgates(1, 0), andgates(0, 1), sum1(0), c1(0));
	HA1: entity work.HalfAdder port map (andgates(3, 1), c1(2), sum1(3), c1(3));
	HA2: entity work.HalfAdder port map (andgates(0, 2), sum1(1), sum2(0), c2(0));
	HA3: entity work.HalfAdder port map (andgates(0, 3), sum2(1), sum3(0), c3(0));
	
	FA0: entity work.FullAdder port map (andgates(2, 0), andgates(1, 1), c1(0), sum1(1), c1(1));
	FA1: entity work.FullAdder port map (andgates(3, 0), andgates(2, 1), c1(1),sum1(2), c1(2));
	
	FA2: entity work.FullAdder port map (andgates(1, 2), sum1(2), c2(0), sum2(1), c2(1));
	FA3: entity work.FullAdder port map (andgates(2, 2), sum1(3), c2(1), sum2(2), c2(2));
	FA4: entity work.FullAdder port map (andgates(3, 2), c1(3), c2(2), sum2(3), c2(3));
	
	FA5: entity work.FullAdder port map (andgates(1, 3), sum2(2), c3(0), sum3(1), c3(1));
	FA6: entity work.FullAdder port map (andgates(2, 3), sum2(3), c3(1), sum3(2), c3(2));
	FA7: entity work.FullAdder port map (andgates(3, 3), c2(3), c3(2), sum3(3), c3(3));
	
	
	oMult(0) <= A(0) and B(0);
	oMult(1) <= sum1(0);
	oMult(2) <= sum2(0);
	oMult(3) <= sum3(0);
	oMult(4) <= sum3(1);
	oMult(5) <= sum3(2);
	oMult(6) <= sum3(3);
	oMult(7) <= c3(3);
end behaviour;


--FOR YOUR INFORMATION: 
--	I almost managed to implement the Multiplier just using generate functions, by making several arrays and using 3 patterns, 
-- but I ran out of time so I wrote this big block of FullAdders
-- Also there were a lot of if conditions within the generate loop so I'm not sure if it was better anyways...
