----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2025 12:13:02 PM
-- Design Name: 
-- Module Name: Counter - Behavioral
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
-- Arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity Counter is
    Port ( Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Data_in : in STD_LOGIC_VECTOR (2 downto 0);
           PC_out : out STD_LOGIC_VECTOR (2 downto 0));
end Counter;

architecture Behavioral of Counter is
    -- Single register with no intermediate signals
    signal PC_reg : std_logic_vector(2 downto 0);
begin
    -- Optimized process with minimal resource usage
    process(Clk, Res)
    begin
        if Res = '1' then
            PC_reg <= "000";
        elsif rising_edge(Clk) then
            -- Simple conditional logic with reduced register impact
            if Data_in(2) = '1' then
                -- Jump directly to provided address
                PC_reg <= Data_in;
            else
                -- Simplified counter logic that synthesizes to fewer registers
                -- This explicit implementation avoids conversion operations
                case PC_reg is
                    when "000" => PC_reg <= "001";
                    when "001" => PC_reg <= "010";
                    when "010" => PC_reg <= "011";
                    when "011" => PC_reg <= "100";
                    when "100" => PC_reg <= "101";
                    when "101" => PC_reg <= "110";
                    when "110" => PC_reg <= "111";
                    when others => PC_reg <= "000";
                end case;
            end if;
        end if;
    end process;
    
    -- Direct assignment
    PC_out <= PC_reg;
    
end Behavioral;

