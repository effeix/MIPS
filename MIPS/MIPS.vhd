library ieee;
use ieee.std_logic_1164.all;

entity MIPS is
	
	port (
	
		in_a   : in  std_logic;
		output : out std_logic
	
	);

end entity;

architecture bhv of MIPS is
begin

	output <= in_a;

end;
