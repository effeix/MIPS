library ieee;
use ieee.std_logic_1164.all;


entity CUAlu is
	port (
		alu_op  		: in  std_logic_vector(1 downto 0);
		funct 		: in std_logic_vector(5 downto 0);
		alu_ctrl		: out std_logic_vector(3 downto 0)
	);	
end entity;


architecture bhv of CUAlu is
begin 
	
		alu_ctrl <= "0010" when alu_op = "00" else 
					   "0110" when alu_op = "01" else 
					   "0010" when alu_op = "10" and funct = "100000" else 
					   "0110" when alu_op = "10" and funct = "100010" else
					   "0000" when alu_op = "10" and funct = "100100" else
					   "0001" when alu_op = "10" and funct = "100101" else
					   "0111" when alu_op = "10" and funct = "101010";

	
end architecture;