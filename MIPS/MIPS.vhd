library ieee;
use ieee.std_logic_1164.all;

entity MIPS is
	
	port (
		CLOCK_50 : in STD_LOGIC;
		
		--saidas de teste p debug
		--opcode 		: out std_logic_vector(5 downto 0);
		--memout  		: out std_logic_vector(31 downto 0);
		--alu_out : out std_logic_vector(31 downto 0);
		--r1_data, r2_data : out std_logic_vector(31 downto 0);
		--rs_out, rt_out, rd_out : out std_logic_vector(4 downto 0);
		--mux1_out  : out std_logic_vector(31 downto 0);
		--in_a_mux1  : out std_logic_vector(31 downto 0);
		--sel_mux1 : out std_logic
		
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) --display7segplaca
	);

end entity;

architecture bhv of MIPS is

	signal opcode_sig : std_logic_vector (5 downto 0);
	signal df_ctrl_sig : std_logic_vector (9 downto 0);
	signal clk_out_sig: std_logic;
	
	--saidas de teste p debug
	signal memout_sig, alu_out_sig, r1_data_sig, r2_data_sig : std_logic_vector (31 downto 0);
	
begin
	
	CDV : entity work.ClockDivisor
	port map (
		clk_in => CLOCK_50,
		reset => '0', 
		clk_out => clk_out_sig
	);
	
	CUDF : entity work.CUDataFlow
	port map (
		opcode => opcode_sig,
		df_ctrl => df_ctrl_sig
	);
	
	
	DF : entity work.DataFlow 
	port map ( 
		clk =>   clk_out_sig,
		df_ctrl => df_ctrl_sig,
		opcode  => opcode_sig,
		memout => memout_sig,
		alu_out1 => alu_out_sig,
		r1_data_out => r1_data_sig,
		r2_data_out => r2_data_sig
		
		--saidas de teste p debug
		--rs => rs_out,
		--rt => rt_out,
	   --rd => rd_out,
		--mux1_out_d  => mux1_out,
		--in_a_mux1_d => in_a_mux1,
		--sel_mux1_d => sel_mux1
	);
	
	CH7S0 : entity work.ConversorHex7Seg
	port map (
		dadoHex => memout_sig(3 downto 0), --talvez inverter
		saida7seg => HEX0
	);
	
	CH7S1 : entity work.ConversorHex7Seg
	port map (
		dadoHex => "0000",
		saida7seg => HEX1
	);
	
	CH7S2 : entity work.ConversorHex7Seg
	port map (
		dadoHex => alu_out_sig(3 downto 0),
		saida7seg => HEX2
	);
	
	CH7S3: entity work.ConversorHex7Seg
	port map (
		dadoHex => "0000",
		saida7seg => HEX3
	);
	
	CH7S4 : entity work.ConversorHex7Seg
	port map (
		dadoHex => r1_data_sig(3 downto 0),
		saida7seg => HEX4
	);
	
	CH7S5 : entity work.ConversorHex7Seg
	port map (
		dadoHex => r2_data_sig(3 downto 0),
		saida7seg => HEX5
	);
	
	CH7S6 : entity work.ConversorHex7Seg
	port map (
		dadoHex => "0000",
		saida7seg => HEX6
	);
	
	CH7S7 : entity work.ConversorHex7Seg
	port map (
		dadoHex => "0000",
		saida7seg => HEX7
	);
	
	--saidas de teste p debug
	--memout <= memout_sig;
	--opcode <= opcode_sig;
	--alu_out <=alu_out_sig;
	--r1_data <= r1_data_sig;
	--r2_data <= r2_data_sig;
	
	
	
end;
