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
    component adder_subtractor_4bit is
        Port ( 
            A       : in  STD_LOGIC_VECTOR (3 downto 0);
            B       : in  STD_LOGIC_VECTOR (3 downto 0);
            Sub     : in  STD_LOGIC;
            S       : out STD_LOGIC_VECTOR (3 downto 0);
            Overflow : out STD_LOGIC;
            Zero     : out STD_LOGIC
        );
    end component;
    
    -- Test signals
    signal A, B : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Sub : STD_LOGIC := '0';
    signal S : STD_LOGIC_VECTOR(3 downto 0);
    signal Overflow, Zero : STD_LOGIC;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: adder_subtractor_4bit port map (
        A => A,
        B => B,
        Sub => Sub,
        S => S,
        Overflow => Overflow,
        Zero => Zero
    );
    
    -- Test process
    process
    begin
        -- Test Case 1: Addition 3 + 4 = 7
        A <= "0011"; B <= "0100"; Sub <= '0';
        wait for 10 ns;
        
        -- Test Case 2: Addition with overflow 7 + 2 = 9 (overflow)
        A <= "0111"; B <= "0010"; Sub <= '0';
        wait for 10 ns;
        
        -- Test Case 3: Subtraction 7 - 3 = 4
        A <= "0111"; B <= "0011"; Sub <= '1';
        wait for 10 ns;
        
        -- Test Case 4: Subtraction with negative result 3 - 7 = -4
        A <= "0011"; B <= "0111"; Sub <= '1';
        wait for 10 ns;
        
        -- Test Case 5: Zero result 5 - 5 = 0
        A <= "0101"; B <= "0101"; Sub <= '1';
        wait for 10 ns;
        
        -- Test Case 6: Negative numbers -3 + -2 = -5
        A <= "1101"; B <= "1110"; Sub <= '0';
        wait for 10 ns;
        
        -- Test Case 7: Subtraction with overflow -5 - 4 = -9 (overflow)
        A <= "1011"; B <= "0100"; Sub <= '1';
        wait for 10 ns;
        
        wait;
    end process;
end sim;