library ieee;
use ieee.std_logic_1164.all;

entity FullAdder32 is
	
	port (
		in_a, in_b, in_carry : in  std_logic_vector(15 downto 0);
		out_carry            : out std_logic;
		sum                  : out std_logic_vector(15 downto 0)
	);

end entity;

architecture bhv of FullAdder32 is

	component FullAdder1 is
		
		port (
			in_a, in_b, in_carry : in  std_logic;
			sum, out_carry       : out std_logic
		);
	
	end component;
	
	signal s : std_logic_vector(14 downto 0);
	
begin

	FA0  : FullAdder1 port map (in_a(0), in_b(0), in_carry, sum(0), s(0));
	FA1  : FullAdder1 port map (in_a(1), in_b(1), s(0), sum(1), s(1));
	FA2  : FullAdder1 port map (in_a(2), in_b(2), s(1), sum(2), s(2));
	FA3  : FullAdder1 port map (in_a(3), in_b(3), s(2), sum(3), s(3));
	FA4  : FullAdder1 port map (in_a(4), in_b(4), s(3), sum(4), s(4));
	FA5  : FullAdder1 port map (in_a(5), in_b(5), s(4), sum(5), s(5));
	FA6  : FullAdder1 port map (in_a(6), in_b(6), s(5), sum(6), s(6));
	FA7  : FullAdder1 port map (in_a(7), in_b(7), s(6), sum(7), s(7));
	FA8  : FullAdder1 port map (in_a(8), in_b(8), s(7), sum(8), s(8));
	FA9  : FullAdder1 port map (in_a(9), in_b(9), s(8), sum(9), s(9));
	FA10 : FullAdder1 port map (in_a(10), in_b(10), s(9), sum(10), s(10));
	FA11 : FullAdder1 port map (in_a(11), in_b(11), s(10), sum(11), s(11));
	FA12 : FullAdder1 port map (in_a(12), in_b(12), s(11), sum(12), s(12));
	FA13 : FullAdder1 port map (in_a(13), in_b(13), s(12), sum(13), s(13));
	FA14 : FullAdder1 port map (in_a(14), in_b(14), s(13), sum(14), s(14));
	FA15 : FullAdder1 port map (in_a(15), in_b(15), s(14), sum(15), s(15));
	FA16 : FullAdder1 port map (in_a(16), in_b(16), s(15), sum(16), s(16));
	FA17 : FullAdder1 port map (in_a(17), in_b(17), s(16), sum(17), s(17));
	FA18 : FullAdder1 port map (in_a(18), in_b(18), s(17), sum(18), s(18));
	FA19 : FullAdder1 port map (in_a(19), in_b(19), s(18), sum(19), s(19));
	FA20 : FullAdder1 port map (in_a(20), in_b(20), s(19), sum(20), s(20));
	FA21 : FullAdder1 port map (in_a(21), in_b(21), s(20), sum(21), s(21));
	FA22 : FullAdder1 port map (in_a(22), in_b(22), s(21), sum(22), s(22));
	FA23 : FullAdder1 port map (in_a(23), in_b(23), s(22), sum(23), s(23));
	FA24 : FullAdder1 port map (in_a(24), in_b(24), s(23), sum(24), s(24));
	FA25 : FullAdder1 port map (in_a(25), in_b(25), s(24), sum(25), s(25));
	FA26 : FullAdder1 port map (in_a(26), in_b(26), s(25), sum(26), s(26));
	FA27 : FullAdder1 port map (in_a(27), in_b(27), s(26), sum(27), s(27));
	FA28 : FullAdder1 port map (in_a(28), in_b(28), s(27), sum(28), s(28));
	FA29 : FullAdder1 port map (in_a(29), in_b(29), s(28), sum(29), s(29));
	FA30 : FullAdder1 port map (in_a(30), in_b(30), s(29), sum(30), s(30));
	FA31 : FullAdder1 port map (in_a(31), in_b(31), s(30), sum(31), out_carry);
	
end architecture;