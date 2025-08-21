----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 04:17:38 PM
-- Design Name: 
-- Module Name: tb_adder_subtractor - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity tb_adder_subtractor is
end tb_adder_subtractor;

architecture sim of tb_adder_subtractor is
    -- Component declaration
    component adder_subtractor_8bit is
        Port ( 
            A       : in  STD_LOGIC_VECTOR (7 downto 0);
            B       : in  STD_LOGIC_VECTOR (7 downto 0);
            Sub     : in  STD_LOGIC;
            S       : out STD_LOGIC_VECTOR (7 downto 0);
            Overflow : out STD_LOGIC;
            Zero     : out STD_LOGIC;
            Negative_flag : out STD_LOGIC 
        );
    end component;
    
    -- Test signals
    signal A, B : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal Sub : STD_LOGIC := '0';
    signal S : STD_LOGIC_VECTOR(7 downto 0);
    signal Overflow, Zero, Negative_flag : STD_LOGIC;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: adder_subtractor_8bit port map (
        A => A,
        B => B,
        Sub => Sub,
        S => S,
        Overflow => Overflow,
        Zero => Zero,
        Negative_flag => Negative_flag
    );
    
    -- Test process
    process
    begin
              -- Test Case 1: Addition 3 + 4 = 7
    A <= "00000011"; B <= "00000100"; Sub <= '0';
    wait for 10 ns;

        -- 3 - 2
   A <= "00000010"; B <= "00000011"; Sub <= '1';
     wait for 10 ns;


    -- Test Case 3: Subtraction 127 - 3 = 124
    A <= "01111111"; B <= "00000011"; Sub <= '1';
    wait for 10 ns;

    -- Test Case 4: Subtraction with negative result 3 - 7 = -4
    A <= "00000011"; B <= "00000111"; Sub <= '1';
    wait for 10 ns;

    -- Test Case 5: Zero result 5 - 5 = 0
    A <= "00000101"; B <= "00000101"; Sub <= '1';
    wait for 10 ns;

    -- Test Case 6: Negative numbers -3 + -2 = -5
    A <= "11111101"; B <= "11111110"; Sub <= '0';         
    wait for 10 ns;

    -- Test Case 7: Subtraction with overflow -5 - 4 = -9
    A <= "11111011"; B <= "00000100"; Sub <= '1';
    wait for 10 ns;

        
        wait;
    end process;
end sim;