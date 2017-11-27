library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity RomUnit is
	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 8
	);

	port 
	(
		clk	: in std_logic;
		addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end entity;


architecture bhv of RomUnit is

	-- Build a 2-D array type for the ROM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

	function init_rom
		return memory_t is 
		variable tmp : memory_t := (others => (others => '0'));
	begin 
		for addr_pos in 0 to 2**ADDR_WIDTH - 1 loop 
			-- Initialize each address with the address itself
			tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, DATA_WIDTH));
		end loop;
		return tmp;
	end init_rom;	 

	-- Declare the ROM signal and specify a default value.	Quartus Prime
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	signal rom : memory_t := init_rom;

begin

	q <= rom(addr/4);

	
	rom(0) <= "00000000001000100101000000100000"; --rb(10) = add rb(1), rb(2)  --OK
	rom(1) <= "00000000011001000101100000100010"; --rb(11) = sub rb(3), rb(4)  --OK
	rom(2) <= "10101100101001110000000000000000"; --sw em memoria(r[5]=5) o valor de r[7]=7
	rom(3) <= "10001100101010000000000000000000"; --lw da memoria(r[5]=5) o valor em r[8]
	rom(4) <= "00000000110001010110100000101010"; --slt rb(6)=6,  rb(5)=5 guarda em rb(13)
	rom(5) <= "00000000110001010110100000100101"; --or rb(6)=6,  rb(5)=5 guarda em rb(13)
	rom(6) <= "00000000110001010110100000100100"; --and rb(6)=6,  rb(5)=5 guarda em rb(13)
	rom(7) <= "00001000000000000000000000000000"; --jmp 0x00000000
	
end architecture;
