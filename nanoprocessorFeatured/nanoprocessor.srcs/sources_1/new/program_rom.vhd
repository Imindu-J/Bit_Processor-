---------------------------------------------------------------------------------- 8 bit Program ROM
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 05:12:41 PM
-- Design Name: 
-- Module Name: program_rom - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8-bit version of program ROM
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created (4-bit version)
-- Revision 0.02 - Updated to 8-bit version with 16-bit instructions
-- Additional Comments:
-- Updated for 8-bit immediate values and 16-bit instruction format
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_rom is
    port (
        addr      : in  std_logic_vector(2 downto 0);  -- 3 bits for 8 memory locations (0-7)
        data_out  : out std_logic_vector(15 downto 0)  -- 16-bit instruction output (was 11 downto 0)
    );
end program_rom;

architecture Behavioral of program_rom is
    -- Define the ROM type - exactly 8 memory locations with 16-bit instructions
    type rom_type is array (0 to 7) of std_logic_vector(15 downto 0);
    
    -- Initialize ROM with program instructions
    -- Updated format for 8-bit instruction set:
    -- MOVI R, d:  10RRR00000000dddddddd (16-bit with 8-bit immediate)
    -- ADD Ra, Rb: 00RaRaRaRbRbRb0000000000 (16-bit)
    -- NEG R:      01RRR000000000000000 (16-bit)
    -- JZR R, d:   11RRR00000000000ddd (16-bit with 3-bit jump address)
    
constant rom : rom_type := (
    -- Example program: Demonstrate 8-bit arithmetic operations
    -- Program calculates: result = 50 + 100 - 75 + 25 = 100
    
    --Basic rom
    0 => "1011100000000000",  -- MOVI R7, 0      (Initialize result register to 0)
    1 => "1001000011001110",  -- MOVI R2, -50     (Load -50 into R2)
    2 => "1000100001100100",  -- MOVI R1, 100    (Load 100 into R1)       
    3 => "0011100100000000",  -- ADD R7, R1      (R7 = 0 + 100 = 100)                           
    4 => "0011101000000000",  -- ADD R7, R2      (R7 = 100 + -50 = 50)
    5 => "1001000001001011",  -- MOVI R2, 75     (Load 75 into R2)
    6 => "0101000000000000",  -- NEG R2          (R2 = -75)
    7 => "0011101000000000"   -- ADD R7, R2      (R7 = 50 + (-75) = -25) 
 
 
      --  shows negative values
--    0 => "1011100000000000",  -- MOVI R7, 0      (Initialize result register to 0)
--    1 => "1011100011111111",  -- MOVI R7, -1     (Load -50 into R2)
--    2 => "1011100011111011",  -- MOVI R7, -5    (Load 100 into R1)       
--    3 => "1011100010110101",  -- MOVI R7, -75      (R7 = 0 + 100 = 100)                           
--    4 => "1011100000000001",  -- MOVI R7, 1     (R7 = 100 + -50 = 50)
--    5 => "1011100000000101",  -- MOVI R7, 5     (Load 75 into R2)
--    6 => "1011100001111111",  -- MOVI R7, 127         (R2 = -75)
--    7 => "1011100010000000"   -- MOVI R7, -128      (R7 = 50 + (-75) = -25) 
    
    -- Implements jump
   
--    0 => "1011100000000000",  -- MOVI R7, 0      (Initialize result register to 0)
--    1 => "1001000010011100",  -- MOVI R2, -100   (Load -100 into R2)
--    2 => "1000100000110010",  -- MOVI R1, 50     (Load 50 into R1)       
--    3 => "0011100100000000",  -- ADD R7, R1      (R7 = 0 + 50 = 50)                           
--    4 => "0011101000000000",  -- ADD R7, R2      (R7 = 50 - 100 = -50)
--    5 => "1100000000000111",  -- JZR R0,7        (Jump to 7)
--    6 => "0101000000000000",  -- NEG R2          (R2 = 100)
--    7 => "0011100100000000"   -- ADD R7, R1      (R7 = -50 + 100 = 50)  

    
    -- Loop example with 8-bit values:
    -- 0 => "1011100000000000",  -- MOVI R7, 0      (Initialize sum to 0)
    -- 1 => "1001000000001010",  -- MOVI R2, 10     (Counter = 10)
    -- 2 => "1000100000000001",  -- MOVI R1, 1      (Decrement value = 1)
    -- 3 => "0111100000000000",  -- NEG R7          (Make decrement negative)
    -- 4 => "0011110100000000",  -- ADD R7, R2      (Add counter to sum)
    -- 5 => "0001000010000000",  -- ADD R2, R1      (Decrement counter by 1)
    -- 6 => "1101000000000100",  -- JZR R2, 4       (Jump to address 4 if R2 != 0)
    -- 7 => "1110000000000111"   -- JZR R0, 7       (End - infinite loop)
);
    
begin
    -- Simple ROM read logic - direct connection from address to output
    data_out <= rom(to_integer(unsigned(addr)));
    
end Behavioral;