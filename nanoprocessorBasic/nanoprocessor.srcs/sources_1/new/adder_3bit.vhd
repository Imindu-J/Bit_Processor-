----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025
-- Design Name: 
-- Module Name: adder_3bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: DSP-based 3-bit adder for incrementing by 1
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

entity adder_3bit is
    Port ( 
        a   : in  STD_LOGIC_VECTOR (2 downto 0);
        sum : out STD_LOGIC_VECTOR (2 downto 0)
    );
end adder_3bit;

architecture DSP_Implementation of adder_3bit is
    -- Attribute to guide synthesis tool to infer DSP blocks
    attribute use_dsp : string;
    
    -- Internal signals
    signal a_unsigned : UNSIGNED(2 downto 0);
    signal result_unsigned : UNSIGNED(2 downto 0);
    
    -- Mark the computation for DSP inference
    attribute use_dsp of result_unsigned : signal is "yes";
    
    -- Constant for increment value
    constant ONE : UNSIGNED(2 downto 0) := "001";
    
begin
    -- Convert input to unsigned for arithmetic
    a_unsigned <= UNSIGNED(a);
    
    -- DSP-optimized increment operation
    -- This operation will be mapped to DSP resources during synthesis
    result_unsigned <= a_unsigned + ONE;
    
    -- Convert result back to STD_LOGIC_VECTOR
    sum <= STD_LOGIC_VECTOR(result_unsigned);
    
end DSP_Implementation;