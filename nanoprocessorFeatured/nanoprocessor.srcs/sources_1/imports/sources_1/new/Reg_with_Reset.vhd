----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2025 12:40:20
-- Design Name: 
-- Module Name: Reg_with_Reset - Behavioral
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

entity Reg_with_Reset is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end Reg_with_Reset;

architecture Behavioral of Reg_with_Reset is

begin
    process (Clk) begin
        if (rising_edge(Clk)) then
            if Reset = '1' then
                Q <= "00000000";
            else
                if En = '1' then
                    Q <= D;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
