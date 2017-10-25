library ieee;
use ieee.std_logic_1164.all;


entity FullAdder1 is
	port (
		in_a, in_b, in_carry  : in  std_logic;
		sum, out_carry        : out std_logic
	);	
end entity;


architecture bhv of FullAdder1 is
begin 
	
	sum <= in_a xor in_b xor in_carry;
	out_carry <= ((in_a and in_b) or (in_b and in_carry) or (in_a and in_carry));
	
end architecture;