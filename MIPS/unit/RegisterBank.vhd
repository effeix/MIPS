library ieee;
use ieee.std_logic_1164.all;

entity RegisterBank is
	generic 
	( 
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 5
	);

	port
	(
		clk        					  : in std_logic;
		addr_r1, addr_r2, addr_r3 : in natural range 0 to 2**ADDR_WIDTH-1;
		data_r3						  : in std_logic_vector((DATA_WIDTH -1) downto 0);
		we_r3							  : in std_logic;
		read_r1, read_r2          : out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end entity;


architecture bhv of RegisterBank is

	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

	signal regs : memory_t := (
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000000",
		x"00000007",
		x"00000006",
		x"00000005",
		x"00000004",
		x"00000003",
		x"00000002",
		x"00000001",
		x"00000000"
	);

begin
	
	process(clk)
	begin
	
		if(rising_edge(clk)) then
			if (we_r3 = '1') then
				regs(addr_r3) <= data_r3;	
			end if;
		end if;
		
	end process;
	
	read_r1 <= regs(addr_r1);

	read_r2 <= regs(addr_r2);

end architecture;
