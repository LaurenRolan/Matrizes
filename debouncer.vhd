----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:29:23 09/29/2016 
-- Design Name: 
-- Module Name:    debouncer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
    Port ( botao : in  STD_LOGIC;
			  clk: in std_logic;
           saida : out  STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
signal running:std_logic:='0';
begin
process(botao,clk)
variable counter: integer range 0 to 50000000:=0;
begin
if(rising_edge(clk))then
	if(running='0' and botao='1')then
		running<='1';
		saida<='1';
	elsif(running='1')then
	saida<='0';
	counter:=counter+1;
		if(counter=50000000)then
		counter:=0;
		running<='0';
		end if;
	else saida<='0';
	end if;
end if;
end process;
end Behavioral;
