library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity DataFlow is
	port( 
		clk   :   in std_logic;
		df_ctrl :   in std_logic_vector(9 downto 0);
		opcode  : out std_logic_vector(5 downto 0)
	);
end entity;


architecture bhv of DataFlow is

	signal mux1_out, mux2_out, mux3_out, mux4_out : std_logic_vector(31 downto 0);
	signal pc_out, rom_out, pc_inc_out : std_logic_vector(31 downto 0);

begin

	PC : entity work.register_unit --program counter register
	port map (
		d => mux1_out,
		we => '1',
		clr => '0',
		clk => clk,
		q => pc_out
	);
	
	ROM : entity work.Rom 
	port map (
		clk	=> clk,
		addr	=> to_integer(unsigned(pc_out)),
		q		=> rom_out
	);
	
	PC_INCREMENTER : entity work.FullAdder32 
	port map (
		in_a => "00000000000000000000000000000100", 
		in_b => pc_out, 
		in_carry => '0', 
		sum => pc_inc_out, 
		cout_30 => open, 
		cout_31 => open
	);
	
end architecture;