library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity square_osc is
		generic ( 
			freq_osc :	real := 32.7032); -- Valor de la frecuencia de la nota deseada
		port ( 
			clk 		:	in	std_logic;
			reset 	:	in	std_logic;
			salida 	:	out	std_logic);
end square_osc;

architecture Behavioral of square_osc is
	constant	fpga_clk_freq	: integer := 50000000;	-- Frecuencia del reloj del FPGA
	signal contador 			: integer range 0 to fpga_clk_freq := 0;
	variable limite			: integer range 0 to fpga_clk_freq;
begin
	limite	<= fpga_clk_freq / freq_osc;
	process ( reset, clk ) 
		variable temporal : std_logic := '0';
		
	begin
		if ( reset = '1' ) then
			temporal := '0';
			contador <= 0;
		elsif	rising_edge ( clk ) then
			if ( contador = limite ) then
				temporal := not ( temporal );
				contador <= 0;
			else
				contador <= contador + 1;
			end if;
		end if;
		salida <= temporal;
	end  process;
end Behavioral;


