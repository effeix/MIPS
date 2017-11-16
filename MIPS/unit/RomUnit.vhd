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

	process(clk)
	
		begin
			if(rising_edge(clk)) then
				q <= rom(addr/4);
			end if;
		end process;
		
	--OBS:
	--Testes de instrucoes R (add e sub), LW e SW bem sucedidas (ler abaixo para mais detalhes)
	--Add de dois registradores iguais deixa tudo maluco
	--Modificar PC para contar de 4 em 4 (estudar isso)
		
	rom(0) <= "00000000001000100101000000100000"; --rb(10)= add rb(1), rb(2)  --OK
	rom(1) <= "00000000011001000101100000100010"; --rb(11)= sub rb(3), rb(4)  --OK
	rom(2) <= "10101100000010100000000000000000"; --sw rb(r[10]) em m(r[0])  --OK (aparece x no lugar de zero)
	rom(3) <= "10101100001010110000000000000000"; --sw rb(r[11]) em m(r[1]) --OK
	rom(4) <= "10001101010000000000000000000000"; --lw m(0) --OK
	
end architecture;
