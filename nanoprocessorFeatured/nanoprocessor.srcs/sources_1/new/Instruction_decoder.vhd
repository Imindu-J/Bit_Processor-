---------------------------------------------------------------------------------- 8 Bit Iinstruction decorder
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 05:27:54 PM
-- Design Name: 
-- Module Name: Instruction_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8-bit version of instruction decoder
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created (4-bit version)
-- Revision 0.02 - Updated to 8-bit version
-- Additional Comments:
-- Updated immediate value from 4-bit to 8-bit for 8-bit ALU compatibility
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Instruction_decoder is
    Port (
        instruction       : in STD_LOGIC_VECTOR (15 downto 0);  -- Expanded from 11 downto 0
        register_check    : in STD_LOGIC_VECTOR (7 downto 0);   -- Changed from 3 downto 0
        immediate_value   : out STD_LOGIC_VECTOR (7 downto 0);  -- Changed from 3 downto 0
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
    signal is_zero_reg : STD_LOGIC;
    
    -- Updated instruction format for 8-bit immediate values:
    -- MOVI R, d:  10RRR00000000dddddddd (16-bit instruction)
    -- ADD Ra, Rb: 00RaRaRaRbRbRb0000000000 (16-bit instruction)
    -- NEG R:      01RRR000000000000000 (16-bit instruction)
    -- JZR R, d:   11RRR00000000000ddd (16-bit instruction)
    
begin
    -- Extract opcode from bits 15:14 (MSB bits)
    op1 <= instruction(15);
    op0 <= instruction(14);
    
    -- Extract register addresses (bits 13:11)
    reg_select_A <= instruction(13 downto 11);
    
    -- Extract 8-bit immediate value (bits 7:0)
    immediate_value <= instruction(7 downto 0);
    
    -- Jump address remains 3-bit (bits 2:0)
    address_to_jump <= instruction(2 downto 0);
    
    -- Decode instruction types
    is_add <= (not op1) and (not op0);     --00
    is_neg <= (not op1) and op0;           --01
    is_movi <= op1 and (not op0);          --10
    is_jzr <= op1 and op0;                 --11
    
    -- Check if register contains zero (8-bit zero check)
    is_zero_reg <= '1' when register_check = "00000000" else '0';
    
    -- reg_select_B logic - use R0 (000) for NEG, otherwise use instruction bits 10:8
    reg_select_B(0) <= instruction(8) and (not is_neg);
    reg_select_B(1) <= instruction(9) and (not is_neg);
    reg_select_B(2) <= instruction(10) and (not is_neg);
    
    -- addsub_select - only '1' for NEG operation
    addsub_select <= is_neg;
    
    -- load_select - only '1' for MOVI operation
    load_select <= is_movi;
    
    -- reg_enable - use regA for ADD, NEG, MOVI (not JZR)
    reg_enable(0) <= instruction(11) and (not is_jzr);
    reg_enable(1) <= instruction(12) and (not is_jzr);
    reg_enable(2) <= instruction(13) and (not is_jzr);
    
    -- jump_flag - only '1' for JZR when register is zero
    jump_flag <= is_jzr and is_zero_reg;
    
end Behavioral;