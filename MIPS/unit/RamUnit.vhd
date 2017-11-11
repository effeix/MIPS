library ieee;
use ieee.std_logic_1164.all;


entity RamUnit is
	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 8
	);
	
	port
	(
		data	: in std_logic_vector(DATA_WIDTH-1 downto 0);
		addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
		we		: in std_logic;
		re 	: in std_logic;
		clk	: in std_logic;
		q		: out std_logic_vector(DATA_WIDTH-1 downto 0)
	);	
end entity;


architecture bhv of RamUnit is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(DATA_WIDTH-1 downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : memory_t;
	
	-- Register to hold the address
	signal addr_reg : natural range 0 to 2**ADDR_WIDTH - 1;

begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we = '1') then
				ram(addr) <= data;
			end if;
			
			-- Register the address for reading
			if(re = '1') then
				addr_reg <= addr;
			end if;
		end if;
	
	end process;
	
	q <= ram(addr_reg);
	
end architecture;