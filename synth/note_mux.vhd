library ieee;
use ieee.std_logic_1164.all;

entity note_mux is
	port 
	(
		clk		: in 	std_logic;
		entrada 	: in	std_logic_vector(7 downto 0);
		sel 		: in	std_logic_vector(7 downto 0);
		salida 	: out std_logic
	);

end entity;

architecture rtl of note_mux is
	constant limite_cont	: integer := 5000;
	shared variable contador		: integer range 0 to limite_cont;
	shared variable indice		: integer range 0 to 7;
begin
--	with sel select
--		salida <= entrada(0)	when "00000001",
--					 entrada(1) when "00000010",
--					 entrada(2) when "00000100",
--					 entrada(3) when "00001000",
--					 entrada(4) when "00010000",
--					 entrada(5) when "00100000",
--					 entrada(6)	when "01000000",
--					 entrada(7)	when "10000000",
--					 '0' when others;
					 
	process(clk, sel)
	begin
		if (rising_edge(clk)) then 
			if (contador = limite_cont) then
				indice := indice + 1;
				for n in 0 to 7 loop
					if (sel(indice) = '0')
						then indice := indice + 1;
					end if;
				end loop;
				salida <= sel(indice);
				contador := 0;
			else
				contador := contador + 1;
			end if;
		end if;
	end process;
	
end rtl;
