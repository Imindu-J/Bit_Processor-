----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 05:12:41 PM
-- Design Name: 
-- Module Name: program_rom - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_rom is
    port (
        addr      : in  std_logic_vector(2 downto 0);  -- 3 bits for 8 memory locations (0-7)
        data_out  : out std_logic_vector(11 downto 0)  -- 12-bit instruction output
    );
end program_rom;

architecture Behavioral of program_rom is
    -- Define the ROM type - exactly 8 memory locations
    type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
    
    -- Initialize ROM with program instructions
    -- Format is based on the instruction set:
    -- MOVI R, d:  10RRR000dddd
    -- ADD Ra, Rb: 00RaRaRaRbRbRb0000
    -- NEG R:      01RRR0000000
    -- JZR R, d:   11RRR0000ddd
constant rom : rom_type := (
        -- code works but no jump or neg instructions | total lut 21, PC counter LUT 13
--        0 => "101110000000",  -- MOVI R7, 0    (Initialize result register to 0)
--        1 => "100100000001",  -- MOVI R2, 1    (Initialize counter to 1)
--        2 => "100010000001",  -- MOVI R1, 1    (Set increment value to 1)
--        3 => "001110100000",  -- ADD R7, R2    (Add current counter to sum in R7)
--        4 => "000100010000",  -- ADD R2, R1    (Increment counter to 2)
--        5 => "001110100000",  -- ADD R7, R2    (Add current counter to sum in R7)
--        6 => "000100010000",  -- ADD R2, R1    (Increment counter to 3)
--        7 => "001110100000"   -- ADD R7, R2    (Add current counter to sum in R7)


        -- works. used jump and neg.. takes more LUTs
--        "101110000011",     -- MOVI R7, 3 
--        "100010000001",     -- MOVI R1, 1 
--        "010010000000",     -- NEG  R1        -1
--        "100100000011",     -- MOVI R2, 3     
--        "000100010000",     -- ADD  R2, R1    2    1
--        "001110100000",     -- ADD  R7, R2    5    6
--        "110100000110",     -- JZR  R2, 6 
--        "110000000100"      -- JZR  R0, 4

    -- work
        0 => "100010000001",  -- MOVI R1, 1       ; R1 = 1
        1 => "001110010000",  -- ADD R7, R1       ; R7 = 0 + 1
        2 => "100010000010",  -- MOVI R1, 2       ; R1 = 2
        3 => "001110010000",  -- ADD R7, R1       ; R7 = 1 + 2
        4 => "100010000011",  -- MOVI R1, 3       ; R1 = 3
        5 => "001110010000",  -- ADD R7, R1       ; R7 = 3 + 3 = 6
        6 => "101110000000",  -- move 0 to r7 (filler code)
        7 => "100000000000"   -- move 0 to r0 (filler code)
);
    
begin
    -- Simple ROM read logic - direct connection from address to output
    data_out <= rom(to_integer(unsigned(addr)));
    
end Behavioral;

