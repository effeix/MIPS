library ieee;
use ieee.std_logic_1164.all;

entity Alu is

port( 

	in_a, in_b	:	in std_logic_vector(31 downto 0);
	ctrl			:	in std_logic_vector(3 downto 0);
	output		:	out std_logic_vector(31 downto 0)
	
	);
	
end entity;

architecture bhv of Alu is

signal mux_a_out, mux_b_out, fa_out, and_out, or_out, slt_out : std_logic_vector(31 downto 0);

begin

	process(in_a, in_b, ctrl)
	begin
	
	MUX_A : entity work.Mux port map (in_a, not(in_a), ctrl(3), mux_a_out);
	MUX_B : entity work.Mux port map (in_b, not(in_b), ctrl(2), mux_b_out);
	FULL_ADDER : entity work.FullAdder32 port map (mux_a_out, mux_b_out, ctrl(2), fa_out);
	
	or_out <= mux_a_out or mux_b_out;
	and_out <= mux_a_out and mux_b_out;
	slt_out <= '0'; --CHECK
	
	MUX_ALU_OUT : entity work.Mux4Way port map (slt_out, fa_out, or_out, and_out, ctrl(1 downto 0, output);
	
	end process;
end architecture;