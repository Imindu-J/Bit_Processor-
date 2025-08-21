----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025
-- Design Name: 
-- Module Name: mux_2_3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Optimized 2-to-1 multiplexer for 3-bit inputs
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

entity mux_2_3 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           B : in STD_LOGIC_VECTOR (2 downto 0);
           Sel : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end mux_2_3;

architecture Behavioral of mux_2_3 is
begin
    -- Using conditional signal assignment (when-else)
    -- This is more readable and synthesizes to the same hardware
    Y <= A when Sel = '0' else B;
    
    -- Alternative implementation using with-select
    -- with Sel select
    --     Y <= A when '0',
    --          B when others;
    
    -- Original gate-level implementation (for reference):
    -- Y(0) <= (not Sel and A(0)) or (Sel and B(0));
    -- Y(1) <= (not Sel and A(1)) or (Sel and B(1));
    -- Y(2) <= (not Sel and A(2)) or (Sel and B(2));
end Behavioral;
