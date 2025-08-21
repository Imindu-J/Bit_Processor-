library IEEE;  --8 Bit Adder substractor
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder_subtractor_8bit is
    Port ( 
        A       : in  STD_LOGIC_VECTOR (7 downto 0);  -- Changed from 3 downto 0
        B       : in  STD_LOGIC_VECTOR (7 downto 0);  -- Changed from 3 downto 0
        Sub     : in  STD_LOGIC;                       -- 0: Add, 1: Subtract
        S       : out STD_LOGIC_VECTOR (7 downto 0);  -- Changed from 3 downto 0
        Overflow : out STD_LOGIC;                      -- Overflow flag
        Zero     : out STD_LOGIC;                      -- Zero flag
        Negative_flag : out STD_LOGIC                  -- Negative flag (MSB)
    );
end adder_subtractor_8bit;

architecture DSP_Implementation of adder_subtractor_8bit is
    -- DSP attribute to guide synthesis tools to infer DSP blocks
    attribute use_dsp : string;
    
    signal a_signed : SIGNED(8 downto 0);      -- Changed from 4 downto 0
    signal b_signed : SIGNED(8 downto 0);      -- Changed from 4 downto 0
    signal result_signed : SIGNED(8 downto 0); -- Changed from 4 downto 0
    signal result : STD_LOGIC_VECTOR(7 downto 0); -- Changed from 3 downto 0
    signal a_adjusted : SIGNED(8 downto 0);    -- Changed from 4 downto 0
    
    -- Mark the critical computation for DSP inference
    attribute use_dsp of result_signed : signal is "yes";
begin
    -- Sign extend A and B to 9 bits for overflow detection by assigning 0 as the MSB
    a_signed <= SIGNED('0' & A);
    b_signed <= SIGNED('0' & B);
    
    -- Configure A based on operation (add or subtract)
    -- For subtraction, we use two's complement (invert and add 1)
    a_adjusted <= a_signed when Sub = '0' else
                  -a_signed;
    
    -- DSP-based add/subtract operation
    -- The synthesis tool will infer a DSP block for this computation
    -- DSP blocks have dedicated fast adders and subtractors
    result_signed <= a_adjusted + b_signed;
    
    -- Extract the result (lower 8 bits)
    result <= STD_LOGIC_VECTOR(result_signed(7 downto 0)); -- Changed from 3 downto 0
    S <= result;
    
    -- Overflow detection logic for 8-bit signed arithmetic
    -- Overflow occurs when the sign bit of the result doesn't match what would be expected
    -- based on the signs of the operands
    Overflow <= '1' when (Sub = '0' and ((A(7) = '0' and B(7) = '0' and result(7) = '1') or  -- pos + pos = neg: overflow
                                        (A(7) = '1' and B(7) = '1' and result(7) = '0'))) or -- neg + neg = pos: overflow
                         (Sub = '1' and ((A(7) = '0' and B(7) = '1' and result(7) = '1') or  -- pos - neg = neg: overflow
                                        (A(7) = '1' and B(7) = '0' and result(7) = '0')))    -- neg - pos = pos: overflow
                else '0';
                
    -- Zero flag detection - now checks all 8 bits
    Zero <= '1' when result = "00000000" else '0';
    
    -- Negative flag is MSB (bit 7 instead of bit 3)
    Negative_flag <= result(7);
    
end DSP_Implementation;