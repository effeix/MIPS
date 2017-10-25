library ieee;
use ieee.std_logic_1164.all;


entity FullAdder32 is
	port (
		in_a, in_b 	: in  std_logic_vector(31 downto 0);
		in_carry		: in std_logic;
		sum         : out std_logic_vector(31 downto 0);
		cout_30     : out std_logic;
		cout_31     : out std_logic
	);
end entity;


architecture bhv of FullAdder32 is

	component FullAdder1 is
		port (
			in_a, in_b, in_carry : in  std_logic;
			sum, out_carry       : out std_logic
		);
	end component;
	
	signal r : std_logic_vector(30 downto 0);
	
begin

	FA0  : FullAdder1 port map (in_a(0), in_b(0), in_carry, sum(0), r(0));
	FA1  : FullAdder1 port map (in_a(1), in_b(1), r(0), sum(1), r(1));
	FA2  : FullAdder1 port map (in_a(2), in_b(2), r(1), sum(2), r(2));
	FA3  : FullAdder1 port map (in_a(3), in_b(3), r(2), sum(3), r(3));
	FA4  : FullAdder1 port map (in_a(4), in_b(4), r(3), sum(4), r(4));
	FA5  : FullAdder1 port map (in_a(5), in_b(5), r(4), sum(5), r(5));
	FA6  : FullAdder1 port map (in_a(6), in_b(6), r(5), sum(6), r(6));
	FA7  : FullAdder1 port map (in_a(7), in_b(7), r(6), sum(7), r(7));
	FA8  : FullAdder1 port map (in_a(8), in_b(8), r(7), sum(8), r(8));
	FA9  : FullAdder1 port map (in_a(9), in_b(9), r(8), sum(9), r(9));
	FA10 : FullAdder1 port map (in_a(10), in_b(10), r(9), sum(10), r(10));
	FA11 : FullAdder1 port map (in_a(11), in_b(11), r(10), sum(11), r(11));
	FA12 : FullAdder1 port map (in_a(12), in_b(12), r(11), sum(12), r(12));
	FA13 : FullAdder1 port map (in_a(13), in_b(13), r(12), sum(13), r(13));
	FA14 : FullAdder1 port map (in_a(14), in_b(14), r(13), sum(14), r(14));
	FA15 : FullAdder1 port map (in_a(15), in_b(15), r(14), sum(15), r(15));
	FA16 : FullAdder1 port map (in_a(16), in_b(16), r(15), sum(16), r(16));
	FA17 : FullAdder1 port map (in_a(17), in_b(17), r(16), sum(17), r(17));
	FA18 : FullAdder1 port map (in_a(18), in_b(18), r(17), sum(18), r(18));
	FA19 : FullAdder1 port map (in_a(19), in_b(19), r(18), sum(19), r(19));
	FA20 : FullAdder1 port map (in_a(20), in_b(20), r(19), sum(20), r(20));
	FA21 : FullAdder1 port map (in_a(21), in_b(21), r(20), sum(21), r(21));
	FA22 : FullAdder1 port map (in_a(22), in_b(22), r(21), sum(22), r(22));
	FA23 : FullAdder1 port map (in_a(23), in_b(23), r(22), sum(23), r(23));
	FA24 : FullAdder1 port map (in_a(24), in_b(24), r(23), sum(24), r(24));
	FA25 : FullAdder1 port map (in_a(25), in_b(25), r(24), sum(25), r(25));
	FA26 : FullAdder1 port map (in_a(26), in_b(26), r(25), sum(26), r(26));
	FA27 : FullAdder1 port map (in_a(27), in_b(27), r(26), sum(27), r(27));
	FA28 : FullAdder1 port map (in_a(28), in_b(28), r(27), sum(28), r(28));
	FA29 : FullAdder1 port map (in_a(29), in_b(29), r(28), sum(29), r(29));
	FA30 : FullAdder1 port map (in_a(30), in_b(30), r(29), sum(30), r(30));
	FA31 : FullAdder1 port map (in_a(31), in_b(31), r(30), sum(31), cout_31);
	
	cout_30 <= r(30);
	
end architecture;