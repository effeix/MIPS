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

    MUX_A : entity work.Mux2Way port map (in_a, not(in_a), ctrl(3), mux_a_out);
    MUX_B : entity work.Mux2Way port map (in_b, not(in_b), ctrl(2), mux_b_out);
    FULL_ADDER : entity work.FullAdder32 port map (mux_a_out, mux_b_out, ctrl(2), fa_sum, cout_30, cout_31);
	
    or_out <= mux_a_out or mux_b_out;
    and_out <= mux_a_out and mux_b_out;
    slt_out <= (others => '0');
	 overflow <= cout_30 xor cout_31;
	 slt_out(0) <= fa_sum(31) xor overflow;
	
    MUX_OPS : entity work.Mux4Way port map (slt_out, fa_sum, or_out, and_out, ctrl(1 downto 0), output);
	
end architecture;
