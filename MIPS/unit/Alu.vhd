library ieee;
use ieee.std_logic_1164.all;


entity Alu is
	port( 
		in_a, in_b  :   in std_logic_vector(31 downto 0);
		ctrl        :   in std_logic_vector(3 downto 0);
		output      :   out std_logic_vector(31 downto 0)
	);
end entity;


architecture bhv of Alu is

	signal mux_a_out, mux_b_out, fa_sum, and_out, or_out, slt_out : std_logic_vector(31 downto 0);
	signal cout_30, cout_31, overflow : std_logic;

begin

	MUX_A : entity work.Mux2Way 
	port map (
		in_a => in_a, 
		in_b => not(in_a), 
		sel => ctrl(3), 
		output => mux_a_out
	);
	
	MUX_B : entity work.Mux2Way 
	port map (
		in_a => in_b, 
		in_b => not(in_b), 
		sel => ctrl(2), 
		output => mux_b_out
	);
	
	FULL_ADDER : entity work.FullAdder32 
	port map (
		in_a => mux_a_out, 
		in_b => mux_b_out, 
		in_carry => ctrl(2), 
		sum => fa_sum, 
		cout_30 => cout_30, 
		cout_31 => cout_31
	);

	or_out <= mux_a_out or mux_b_out;
	and_out <= mux_a_out and mux_b_out;
	overflow <= cout_30 xor cout_31;
	slt_out <= "0000000000000000000000000000000" & (fa_sum(31) xor overflow);

	MUX_OPS : entity work.Mux4Way 
	port map (
		in_a => and_out, 
		in_b => or_out, 
		in_c => fa_sum, 
		in_d => slt_out, 
		sel => ctrl(1 downto 0), 
		output => output
	);
	
	
end architecture;
