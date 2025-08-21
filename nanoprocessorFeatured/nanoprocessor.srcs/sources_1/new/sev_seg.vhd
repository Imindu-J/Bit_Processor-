----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2025 16:34:00
-- Design Name: 
-- Module Name: sev_seg - Behavioral
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
entity sev_seg is
    Port ( Data : in STD_LOGIC_VECTOR (3 downto 0);
           Y_7seg : out STD_LOGIC_VECTOR (6 downto 0));
end sev_seg;

architecture Behavioral of sev_seg is
component LUT_16_7 
port (
    address : in std_logic_vector(3 downto 0);
    data : out std_logic_vector(6 downto 0));
end component;
begin
    LUT_16_7_0 : LUT_16_7
        PORT MAP (
            address => Data,
            data => Y_7seg
        );
end Behavioral;