----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 05:27:54 PM
-- Design Name: 
-- Module Name: Instruction_decoder - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Instruction_decoder is
    Port (
        instruction       : in STD_LOGIC_VECTOR (11 downto 0);
        register_check    : in STD_LOGIC_VECTOR (3 downto 0);
        immediate_value   : out STD_LOGIC_VECTOR (3 downto 0);
        load_select       : out STD_LOGIC;
        reg_enable        : out STD_LOGIC_VECTOR (2 downto 0);
        reg_select_A      : out STD_LOGIC_VECTOR (2 downto 0);
        reg_select_B      : out STD_LOGIC_VECTOR (2 downto 0);
        addsub_select     : out STD_LOGIC;
        jump_flag         : out STD_LOGIC;
        address_to_jump   : out STD_LOGIC_VECTOR (2 downto 0)
    );
end Instruction_decoder;

architecture Behavioral of Instruction_decoder is
    signal op0, op1 : STD_LOGIC;
    signal is_add, is_neg, is_movi, is_jzr : STD_LOGIC;
    signal zero_check_0, zero_check_1, zero_check_2, zero_check_3 : STD_LOGIC;
    signal is_zero_reg : STD_LOGIC;
    
    -- Initialize ROM with program instructions
    -- Format is based on the instruction set:
    -- MOVI R, d:  10RRR000dddd
    -- ADD Ra, Rb: 00RaRaRaRbRbRb0000
    -- NEG R:      01RRR0000000
    -- JZR R, d:   11RRR0000ddd
    
begin
    op1 <= instruction(11);
    op0 <= instruction(10);
    reg_select_A <= instruction(9 downto 7);
--    reg_select_B   <= instruction(6 downto 4);
    immediate_value <= instruction(3 downto 0);
    address_to_jump <= instruction(2 downto 0);

    is_add <= (not op1) and (not op0);     --00
    is_neg <= (not op1) and op0;           --01
    is_movi <= op1 and (not op0);          --10
    is_jzr <= op1 and op0;                 --11
    
    is_zero_reg <= (not register_check(0)) and (not register_check(1)) and (not register_check(2)) and (not register_check(3));

     -- reg_select_B logic - use R0 (000) for NEG, otherwise use instruction bits
    reg_select_B(0) <= instruction(4) and (not is_neg);
    reg_select_B(1) <= instruction(5) and (not is_neg);
    reg_select_B(2) <= instruction(6) and (not is_neg);
    
    -- addsub_select - only '1' for NEG operation
    addsub_select <= is_neg;
    
    -- load_select - only '1' for MOVI operation
    load_select <= is_movi;
    
    -- reg_enable - use regA for ADD, NEG, MOVI (not JZR)
    reg_enable(0) <= instruction(7) and (not is_jzr);
    reg_enable(1) <= instruction(8) and (not is_jzr);
    reg_enable(2) <= instruction(9) and (not is_jzr);
    
    -- jump_flag - only '1' for JZR when register is zero
    jump_flag <= is_jzr and is_zero_reg;

end Behavioral;