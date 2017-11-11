library ieee;
use ieee.std_logic_1164.all;


entity register_unit is 
	port(
		d   : in std_logic_vector(31 downto 0);
		we  : in std_logic;
		clr : in std_logic;
		clk : in std_logic;
		q   : out std_logic_vector(31 downto 0)
	);
end entity;


architecture bhv of register_unit is
begin

	process(clk, clr)
	begin
		if clr = '1' then
			q <= x"00000000";
		elsif rising_edge(clk) then
			if we = '1' then
				 q <= d;
			end if;
		end if;
	end process;
	
end architecture;