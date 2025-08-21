----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 03:27:02 PM
-- Design Name: 
-- Module Name: tb_adder_3bit - Behavioral
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

entity tb_adder_3bit is
end tb_adder_3bit;

architecture Behavioral of tb_adder_3bit is

    -- Component declaration
    component adder_3bit
        Port ( 
            a   : in  STD_LOGIC_VECTOR (2 downto 0);
            sum : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Signals for UUT
    signal a   : STD_LOGIC_VECTOR (2 downto 0);
    signal sum : STD_LOGIC_VECTOR (2 downto 0);

begin

    -- Instantiate UUT
    uut: adder_3bit port map (
        a => a,
        sum => sum
    );

    -- Stimulus process
    stim_proc: process
    begin
        a <= "000"; wait for 10 ns;
        a <= "001"; wait for 10 ns;
        a <= "010"; wait for 10 ns;
        a <= "011"; wait for 10 ns;
        a <= "100"; wait for 10 ns;
        a <= "101"; wait for 10 ns;
        a <= "110"; wait for 10 ns;
        a <= "111"; wait for 10 ns;

        wait; -- Stop simulation
    end process;

end Behavioral;
