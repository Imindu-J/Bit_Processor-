----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 02:06:35 PM
-- Design Name: 
-- Module Name: mux_8_4 - Behavioral
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

entity mux_8_8 is
    Port (
        sel : in STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit selector
        d0  : in STD_LOGIC_VECTOR(7 downto 0);
        d1  : in STD_LOGIC_VECTOR(7 downto 0);
        d2  : in STD_LOGIC_VECTOR(7 downto 0);
        d3  : in STD_LOGIC_VECTOR(7 downto 0);
        d4  : in STD_LOGIC_VECTOR(7 downto 0);
        d5  : in STD_LOGIC_VECTOR(7 downto 0);
        d6  : in STD_LOGIC_VECTOR(7 downto 0);
        d7  : in STD_LOGIC_VECTOR(7 downto 0);
        y   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end mux_8_8;

architecture Behavioral of mux_8_8 is
begin
    process(sel, d0, d1, d2, d3, d4, d5, d6, d7)
    begin
        case sel is
            when "000" => y <= d0;
            when "001" => y <= d1;
            when "010" => y <= d2;
            when "011" => y <= d3;
            when "100" => y <= d4;
            when "101" => y <= d5;
            when "110" => y <= d6;
            when "111" => y <= d7;
            when others => y <= (others => '0');  -- Default case
        end case;
    end process;
end Behavioral;
