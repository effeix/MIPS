library ieee;
use ieee.std_logic_1164.all;

entity MIPS is
	
	port (
		clk			: in std_logic;
		
		--saidas de teste p debug
		opcode 		: out std_logic_vector(5 downto 0);
		memout  		: out std_logic_vector(31 downto 0);
		alu_out : out std_logic_vector(31 downto 0);
		r1_data, r2_data : out std_logic_vector(31 downto 0);
		rs_out, rt_out, rd_out : out std_logic_vector(4 downto 0)
	);

end entity;

architecture bhv of MIPS is

	signal opcode_sig : std_logic_vector (5 downto 0);
	signal df_ctrl_sig : std_logic_vector (9 downto 0);
	
	--saidas de teste p debug
	signal memout_sig, alu_out_sig, r1_data_sig, r2_data_sig : std_logic_vector (31 downto 0);
	
begin

	CUDF : entity work.CUDataFlow
	port map (
		opcode => opcode_sig,
		df_ctrl => df_ctrl_sig
	);
	
	
	DF : entity work.DataFlow 
	port map ( 
		clk =>   clk,
		df_ctrl => df_ctrl_sig,
		opcode  => opcode_sig,
		memout => memout_sig,
		alu_out1 => alu_out_sig,
		r1_data_out => r1_data_sig,
		r2_data_out => r2_data_sig,
		
		--saidas de teste p debug
		rs => rs_out,
		rt => rt_out,
		rd => rd_out
	);
	
	--saidas de teste p debug
	memout <= memout_sig;
	opcode <= opcode_sig;
	alu_out <=alu_out_sig;
	r1_data <= r1_data_sig;
	r2_data <= r2_data_sig;
	
	
	
end;
