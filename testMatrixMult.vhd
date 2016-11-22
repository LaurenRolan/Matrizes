--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:31:22 11/22/2016
-- Design Name:   
-- Module Name:   C:/Users/Maria/Desktop/Clara/MatrizMult/testMatrixMult.vhd
-- Project Name:  MatrizMult
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MatrixMult
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testMatrixMult IS
END testMatrixMult;
 
ARCHITECTURE behavior OF testMatrixMult IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MatrixMult
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         s : IN  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal s : std_logic_vector(7 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MatrixMult PORT MAP (
          clk => clk,
          rst => rst,
          s => s
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin			
		rst <= '1';

      wait for clk_period*10;
		
		rst <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
