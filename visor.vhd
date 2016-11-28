----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:45 09/30/2016 
-- Design Name: 
-- Module Name:    visor - Behavioral 
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

entity visor is
    Port ( acc : in  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC;
           anodos : out  STD_LOGIC_VECTOR (3 downto 0);
           segmentos : out  STD_LOGIC_VECTOR (6 downto 0));
end visor;

architecture Behavioral of visor is
signal to_seven, anodo_temp: std_logic_vector (3 downto 0) := "0000";
signal clk_x : std_logic := '0';
--signal flag1, flag2 : std_logic := '0';
begin
process(clk)						--um ciclo de clk_x eh 100.000 ciclos de clk
	variable count: integer range 0 to 50000:=0;
	begin
		if(rising_edge(clk))then
			if(count=50000)then
				count:=0;
				clk_x <= not clk_x;
			--	flag1 <= '1'; -- debug
			else
				count:=count+1;
			end if;
		end if;
	end process;
	
	process(clk_x)						--a cada ciclo de clk_x  exibe um numero dos displays
	begin
	if(rising_edge(clk_x))then
		case anodo_temp is
			when "1110"=> anodo_temp<="1101"; to_seven<=acc(7 downto 4);
			when "1101"=> anodo_temp<="1011"; to_seven<="0000";
			when "1011"=> anodo_temp<="0111"; to_seven<="0000";
			when "0111"=> anodo_temp<="1110"; to_seven<=acc(3 downto 0);
			when others=> anodo_temp<="1110";  to_seven<=acc(3 downto 0);
		end case;
		--flag2 <= '1'; --debug
	end if;
	end process;
	anodos <= anodo_temp;
	
BS: entity work.binseven port map (to_seven, segmentos);

end Behavioral;

