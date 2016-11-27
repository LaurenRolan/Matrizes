----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:46:55 11/22/2016 
-- Design Name: 
-- Module Name:    MatrixMult - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MatrixMult is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC
			  );
end MatrixMult;

architecture Behavioral of MatrixMult is

type STATE is (s0a, s0, s1, s2);
signal estado, proxEstado: STATE;
type matriz is array(0 TO 3, 0 TO 3) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
signal a, b : matriz;
signal x,y,i,j: integer :=0; 
signal rowB,colB: integer :=0; 
signal wea, web :STD_LOGIC_VECTOR(0 DOWNTO 0) := "0";
signal addra, addrb: STD_LOGIC_VECTOR(4 DOWNTO 0); -- era 4 downto 0
signal dina, douta, dinb, doutb : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"; -- era 4
signal ldaA, ldaB, sel, incI, incJ, incX, incY: STD_LOGIC;
signal incEndA, incEndB, zeraI, zeraJ, zeraX, zeraY, compEndA, compJ: STD_LOGIC := '0';
signal c,d,e,f: integer :=0;

begin
 -- FSM 
  process(clk, rst)
  begin
	if(rst = '1') then
		estado <= s0a;
	elsif(rising_edge(clk)) then
		estado <= proxEstado;
	end if;
  end process;
  
  process(clk, estado, proxEstado, compJ, compEndA)
  begin
	case estado is
		when s0a=> incY <='0'; incJ <='0'; incEndA<= '0'; incEndB <= '0'; 
						zeraY <= '0'; zeraJ <='0'; incI<='0'; incX <='0'; proxEstado<= s0;
						ldaA <= '0'; ldaB <= '0';
						
		when s0 => ldaA <='1'; ldaB <='1'; sel <= '1'; proxEstado<= s1;
		
		when s1 => ldaA <='0'; ldaB <='0'; incY <='1'; incJ <='1'; incEndA<= '1'; incEndB <= '1'; 
						if (compJ = '1') then
							proxEstado <= s2;
						else
							proxEstado <= s0a;
						end if;
						
		when s2 => zeraY <= '1'; zeraJ <='1'; incI<='1'; incX <='1';
						if (compEndA = '1') then
							proxEstado <= s2;
						else
							proxEstado <= s0a;
						end if;
		
	end case;
  end process;
-- Comparadores
	compJ <= '1' when (j = 3) else '0'; --?????????
	compEndA <= '1' when (addrA = "10000") else '0'; -- era > "10000" same shit
	
--regA	
		process(clk, rst)
		begin
			if(rst = '1') then  -- funciona just fine
				for e in 3 downto 0 loop
					for f in 3 downto 0 loop
						a(e,f) <= "0000";
					end loop;
				end loop;
				-- até aqui funfa
			elsif (rising_edge(clk)) then
				if(ldaA = '1') then
					a(i,j) <= douta; -- era só douta
				end if;
			end if;
		end process;
	
-- MUX	 
	 rowB <= y when (sel = '1') else x;
	 colB <= x when (sel = '1') else y;
-- regB
		process(clk, rst)
		begin
			if(rst = '1') then 
				for c in 3 downto 0 loop
					for d in 3 downto 0 loop
						b(c,d) <= "0000";
					end loop;					
				end loop;
			elsif (rising_edge(clk)) then
				if(ldaB = '1') then
					b(rowB, colB) <= doutb;
				end if;
			end if;
		end process;
		
-- x
	process(clk, rst)
	begin
		if(rst = '1') then
			x <= 0;
		elsif(rising_edge(clk)) then
			if incX = '1' then
				x<= x +1;
			elsif zerax = '1' then
				x<= 0;
			end if;
		end if;
	end process;
	
-- y
	process(clk, rst)
	begin
		if(rst = '1') then
			y <= 0;
		elsif(rising_edge(clk)) then
			if incy = '1' and y <= 3 then
				y<= y +1;
			elsif zeray = '1' then
				y<= 0;
			end if;
		end if;
	end process;

-- i
	process(clk, rst)
	begin
		if(rst = '1') then
			i <= 0;
		elsif(rising_edge(clk)) then
			if incI = '1' then
				i<= i +1;
			elsif zeraI = '1' then
				i<= 0;
			end if;
		end if;
	end process;
	
-- j
	process(clk, rst)
	begin
		if(rst = '1') then
			j <= 0;
		elsif(rising_edge(clk)) then
			if incj = '1' and j <= 3 then
				j<= j +1;
			elsif zeraj = '1' then
				j<= 0;
			end if;
		end if;
	end process;
	
-- addrA
	process(clk, rst)
	begin
		if(rst = '1') then
			addrA <= "00001";
		elsif(rising_edge(clk)) then
			if incEndA = '1' then
				addrA<= addrA + '1';
				--if addrA = "10000" then compEndA <= '1';
				--else compEndA <= '0'; end if;
			end if;
		end if;
	end process;
-- addrB
	process(clk, rst)
	begin
		if(rst = '1') then
			addrB <= "00001";
		elsif(rising_edge(clk)) then
			if incEndB = '1' then
				addrB<= addrB + '1';
			end if;
		end if;
	end process;
	
-- Memórias
MEMA: entity work.memoA port map (clk, wea, addrA, dina, douta);
MEMB: entity work.memoA port map (clk, web, addrB, dinb, doutb);
		
end Behavioral;