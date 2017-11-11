library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity DataFlow is
	port( 
		clk   :   in std_logic;
		df_ctrl :   in std_logic_vector(9 downto 0);
		opcode  : out std_logic_vector(5 downto 0)
	);
end entity;


architecture bhv of DataFlow is

	signal mux1_out, mux3_out, mux4_out, mux5_out, alu_out : std_logic_vector(31 downto 0);
	signal r1_data, r2_data, ram_data : std_logic_vector(31 downto 0);
	signal pc_out, instruction, pc_inc_out, pc_sigext : std_logic_vector(31 downto 0);
	signal alu_ctrl : std_logic_vector(3 downto 0);
	signal mux2_out : std_logic_vector(4 downto 0);
	signal is_zero  : std_logic;

begin

	PC : entity work.RegisterUnit --program counter register
	port map (
		d => mux1_out,
		we => '1',
		clr => '0',
		clk => clk,
		q => pc_out
	);
	
	ROM : entity work.RomUnit 
	port map (
		clk	=> clk,
		addr	=> to_integer(unsigned(pc_out)),
		q		=> instruction
	);
	
	PC_INCREMENTER : entity work.FullAdder32 
	port map (
		in_a => "00000000000000000000000000000100", 
		in_b => pc_out, 
		in_carry => '0', 
		sum => pc_inc_out, 
		cout_30 => open, 
		cout_31 => open
	);
	
	MUX1 : entity work.Mux2Way --mux PC+4,beq/Jmp
	port map (
		in_a => mux5_out, 
		in_b => pc_out(31 downto 28) & instruction(25 downto 0) & "00", 
		sel => df_ctrl(9), 
		output => mux1_out
	);
	
	MUX2 : entity work.Mux2Way --mux Rt/Rd
	generic map (DATA_WIDTH => 5)
	port map (
		in_a => instruction(20 downto 16), --Rt
		in_b => instruction(15 downto 11), --Rd 
		sel => df_ctrl(8), 
		output => mux2_out
	);
	
	RB : entity work.RegisterBank --mux PC+4,beq/Jmp
	port map (
		clk => clk,
		addr_r1 => to_integer(unsigned(instruction(25 downto 21))), --Rs
		addr_r2 => to_integer(unsigned(instruction(20 downto 16))), --Rt
		addr_r3 => to_integer(unsigned(mux2_out)),
		data_r3 => mux4_out,
		we_r3 => df_ctrl(7),
		read_r1 => r1_data, 
		read_r2 => r2_data
	);
	
	MUX3 : entity work.Mux2Way --mux Rt/Imm
	port map (
		in_a => r2_data,
		in_b => "0000000000000000" & instruction(15 downto 0),
		sel => df_ctrl(6), 
		output => mux3_out
	);
	
	CUALU : entity work.CUAlu
	port map (
		ula_op => df_ctrl(1 downto 0), 
		funct => instruction(5 downto 0),
		ula_ctrl => alu_ctrl
	);
	
	ALU : entity work.Alu
	port map (
		in_a => r1_data, 
		in_b => mux3_out,
		ctrl => alu_ctrl,
		output => alu_out
	);
	
	N32W : entity work.Nor32Way
	port map (
		in_a => alu_out, 
		output => is_zero
	);
	
	FA32 : entity work.FullAdder32 
	port map (
		in_a => pc_inc_out, 
		in_b => "0000000000000000" & instruction(15 downto 0), 
		in_carry => '0', 
		sum => pc_sigext, 
		cout_30 => open, 
		cout_31 => open
	);
	
	MUX5 : entity work.Mux2Way --mux beq
	port map (
		in_a => pc_inc_out,
		in_b => pc_sigext,
		sel => is_zero and df_ctrl(4), 
		output => mux5_out
	);
	
	RAM : entity work.RamUnit 
	port map (
		data => r2_data,
		addr => to_integer(unsigned(alu_out)),
		we => df_ctrl(2),
		re => df_ctrl(3),
		clk => clk,
		q => ram_data
		
	);
	
	MUX4 : entity work.Mux2Way --mux ALU/Mem
	port map (
		in_a => alu_out,
		in_b => ram_data,
		sel => is_zero and df_ctrl(5), 
		output => mux4_out
	);
	
	opcode <= instruction(31 downto 26);
	
end architecture;