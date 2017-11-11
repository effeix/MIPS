library ieee;
use ieee.std_logic_1164.all;


entity CUDataFlow is
	port (
		opcode 		: in  std_logic_vector(5 downto 0);
		df_ctrl		: out std_logic_vector(9 downto 0)
	);	
end entity;


architecture bhv of CUDataFlow is
begin

	--ver pag. 26 slide aula-16
	--valores x substituidos por 0

	df_ctrl <= "0110000010" when opcode = "000000" else 
				  "0011101000" when opcode = "100011" else 
				  "0001000100" when opcode = "101011" else 
				  "0000010001" when opcode = "000100" else
				  "1000000000" when opcode = "000010";
	
end architecture;