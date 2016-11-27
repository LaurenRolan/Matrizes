----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:23 11/21/2016 
-- Design Name: 
-- Module Name:    Multicycles - Behavioral 
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

entity Multicycles is
	port(
		ap_clk : IN STD_LOGIC;
		ap_rst : IN STD_LOGIC;
		ap_start : IN STD_LOGIC;
		ap_done : OUT STD_LOGIC;
		ap_idle : OUT STD_LOGIC;
		ap_ready : OUT STD_LOGIC
	);
end Multicycles;

architecture Behavioral of Multicycles is
signal a_address0 : STD_LOGIC_VECTOR (3 downto 0);
signal a_ce0 : STD_LOGIC;
signal a_q0 : STD_LOGIC_VECTOR (7 downto 0);
signal b_address0 : STD_LOGIC_VECTOR (3 downto 0);
signal b_ce0 : STD_LOGIC;
signal b_q0 : STD_LOGIC_VECTOR (7 downto 0);
signal res_address0 : STD_LOGIC_VECTOR (3 downto 0);
signal res_ce0 : STD_LOGIC;
signal res_we0 : STD_LOGIC;
signal res_d0 : STD_LOGIC_VECTOR (15 downto 0);
signal din_a, din_b : STD_LOGIC_VECTOR (7 downto 0);
signal wer, wea, web : STD_LOGIC_VECTOR (0 downto 0) := "0";
signal dout_r : STD_LOGIC_vECTOR (15 downto 0);

begin

MULTI:	entity work.matrixmul_multi port map(
ap_clk, 
ap_rst, 
ap_start, 
ap_done, 
ap_idle, 
ap_ready, 
a_address0, 
a_ce0, 
a_q0, 
b_address0, 
b_ce0, 
b_q0, 
res_address0,
res_ce0,
res_we0,
res_d0);

MEMA:		entity work.memA port map (ap_clk, wea, a_address0, din_a, a_q0);
MEMB:		entity work.memB port map (ap_clk, web, b_address0, din_b, b_q0);
wer(0) <= res_we0;
MEMR:		entity work.memR port map (ap_clk, wer, res_address0, res_d0, dout_r);

end Behavioral;

