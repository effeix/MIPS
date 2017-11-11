library ieee;
use ieee.std_logic_1164.all;


entity CUAlu is
	port (
		ula_op  		: in  std_logic_vector(1 downto 0);
		funct 		: in std_logic_vector(5 downto 0);
		ula_ctrl		: out std_logic_vector(3 downto 0)
	);	
end entity;


architecture bhv of CUAlu is
begin 
	
		ula_ctrl <= "0010" when ula_op = "00" else 
					   "0110" when ula_op = "01" else 
					   "0010" when ula_op = "10" and funct = "100000" else 
					   "0110" when ula_op = "10" and funct = "100010" else
					   "0000" when ula_op = "10" and funct = "100100" else
					   "0001" when ula_op = "10" and funct = "100101" else
					   "0111" when ula_op = "10" and funct = "101010";

	
end architecture;