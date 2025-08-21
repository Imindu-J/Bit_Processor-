----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.03.2025 17:06:49
-- Design Name: 
-- Module Name: Decoder_2_to_4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Optimized 2-to-4 decoder implementation
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

entity Decoder_2_to_4 is
    Port ( I : in STD_LOGIC_VECTOR (1 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end Decoder_2_to_4;

architecture Behavioral of Decoder_2_to_4 is
begin
    -- Use conditional signal assignment for cleaner implementation
    -- This eliminates the need for explicit NOT signals
    Y <= "0001" when (EN = '1' and I = "00") else
         "0010" when (EN = '1' and I = "01") else
         "0100" when (EN = '1' and I = "10") else
         "1000" when (EN = '1' and I = "11") else
         "0000";
         
    -- Alternative implementation using with-select statement
    -- with EN & I select
    --    Y <= "0001" when "100",
    --         "0010" when "101",
    --         "0100" when "110",
    --         "1000" when "111",
    --         "0000" when others;
end Behavioral;