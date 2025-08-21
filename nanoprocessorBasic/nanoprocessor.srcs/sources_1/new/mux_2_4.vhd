----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 02:01:40 PM
-- Design Name: 
-- Module Name: mux_2_4 - Behavioral
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

entity mux_2_4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end mux_2_4;

architecture Behavioral of mux_2_4 is

begin

Y <= A when Sel = '0' else B;

--Y(0) <= (not Sel and A(0)) or (Sel and B(0));
--Y(1) <= (not Sel and A(1)) or (Sel and B(1));
--Y(2) <= (not Sel and A(2)) or (Sel and B(2));
--Y(3) <= (not Sel and A(3)) or (Sel and B(3));

end Behavioral;
