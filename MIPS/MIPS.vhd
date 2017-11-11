library ieee;
use ieee.std_logic_1164.all;

entity MIPS is
	
	port (
		ula_op  		: in  std_logic_vector(1 downto 0);
		funct 		: in std_logic_vector(5 downto 0);
		in_a, in_b  :   in std_logic_vector(31 downto 0);
		result		: out std_logic_vector(31 downto 0)
	);

end entity;

architecture bhv of MIPS is
	signal CUAlu_out : std_logic_vector (3 downto 0);
begin
	MUX_B : entity work.CUAlu port map (ula_op, funct, CUAlu_out);
	MUX_A : entity work.Alu port map (in_a, in_b, CUAlu_out, result);
end;
