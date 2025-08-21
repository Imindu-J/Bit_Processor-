----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2025 14:14:21
-- Design Name: 
-- Module Name: TB_Reg_Bank - Behavioral
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

entity TB_Reg_Bank is
--  Port ( );
end TB_Reg_Bank;

architecture Behavioral of TB_Reg_Bank is

component Register_Bank
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           Res : in STD_LOGIC; 
           Q0 : out STD_LOGIC_VECTOR (3 downto 0);
           Q1 : out STD_LOGIC_VECTOR (3 downto 0);
           Q2 : out STD_LOGIC_VECTOR (3 downto 0);
           Q3 : out STD_LOGIC_VECTOR (3 downto 0);
           Q4 : out STD_LOGIC_VECTOR (3 downto 0);
           Q5 : out STD_LOGIC_VECTOR (3 downto 0);
           Q6 : out STD_LOGIC_VECTOR (3 downto 0);
           Q7 : out STD_LOGIC_VECTOR (3 downto 0)
           );
end component;

signal Dx :  STD_LOGIC_VECTOR (3 downto 0);
signal Reg_Selx : STD_LOGIC_VECTOR (2 downto 0);
signal Clk : STD_LOGIC := '0';
signal Resx : STD_LOGIC; 
signal Q0x :  STD_LOGIC_VECTOR (3 downto 0);
signal Q1x : STD_LOGIC_VECTOR (3 downto 0);
signal Q2x : STD_LOGIC_VECTOR (3 downto 0);
signal Q3x : STD_LOGIC_VECTOR (3 downto 0);
signal Q4x : STD_LOGIC_VECTOR (3 downto 0);
signal Q5x : STD_LOGIC_VECTOR (3 downto 0);
signal Q6x : STD_LOGIC_VECTOR (3 downto 0);
signal Q7x : STD_LOGIC_VECTOR (3 downto 0);

begin

UUT: Register_Bank port map(
    D => Dx,
    Reg_Sel => Reg_Selx,
    Clk => Clk,
    Res => Resx,
    Q0 => Q0x,
    Q1 => Q1x,
    Q2 => Q2x,
    Q3 => Q3x,
    Q4 => Q4x,
    Q5 => Q5x,
    Q6 => Q6x,
    Q7 => Q7x);
    
process
begin
    Clk <= (not Clk);
    wait for 5ns;
end process;

process
begin
    Dx <= "0011";
    Resx <= '0';
    Reg_Selx <= "010";
    wait for 100ns;
    
    Dx <= "0111";
    Reg_Selx <= "111";
    wait for 100ns;
    
    Dx <= "0110";
    Reg_Selx <= "001";
    wait for 100ns;
    
    Resx <= '1';
    wait;

end process;
end Behavioral;
