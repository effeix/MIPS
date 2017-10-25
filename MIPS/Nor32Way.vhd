library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity Nor32 is
	
	port (
		in_a   : in  std_logic_vector(31 downto 0);
		output : out std_logic
	);

end entity;

architecture bhv of Nor32 is

	signal result : std_logic := '0';

begin

	process(in_a)
	begin
		
		for i in in_a'range loop
			
			result <= result or in_a(i);
		
		end loop;
	
	end process;
	
	output <= not result;
	
end architecture;