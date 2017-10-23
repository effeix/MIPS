library ieee;
use ieee.std_logic_1164.all;


entity Mux is
	port ( 
		in_a, in_b : in std_logic_vector(31 downto 0);
		sel  : in std_logic;
		output : out std_logic_vector(31 downto 0)	
	);	
end entity;


architecture bhv of Mux is
begin
	
	process(in_a, in_b, sel)
	begin
		
		case sel is
			when '0' => output <= in_a;
			when '1' => output <= in_b;
		end case;
		
	end process;
end architecture;