----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2025 11:38:45 AM
-- Design Name: 
-- Module Name: TB_mux_2_3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_mux_2_3 is
--  Port ( );
end TB_mux_2_3;

architecture Behavioral of TB_mux_2_3 is
component mux_2_3 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           B : in STD_LOGIC_VECTOR (2 downto 0);
           Sel : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal A, B, Y : std_logic_vector ( 2 downto 0) := "000";
signal Sel : std_logic;

begin
UUT : mux_2_3
    port map(
    A => A,
    B => B,
    Sel => Sel,
    Y => Y);

process begin
    Sel <= '0';
    A <= "101";
    wait for 20ns;
    
    Sel <= '1';
    B <= "010";
    wait;
end process;

end Behavioral;
