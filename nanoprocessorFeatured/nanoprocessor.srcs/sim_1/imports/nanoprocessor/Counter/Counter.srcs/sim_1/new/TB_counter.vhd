----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2025 12:34:29 PM
-- Design Name: 
-- Module Name: TB_counter - Behavioral
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

entity TB_counter is
--  Port ( );
end TB_counter;

architecture Behavioral of TB_counter is

component Counter is
    Port ( Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Data_in : in STD_LOGIC_VECTOR (2 downto 0);
           PC_out : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal Clk, Res : std_logic;
signal Data_in, PC_out : std_logic_vector (2 downto 0);

begin

UUT: Counter
port map(
    Clk => Clk,
    Res => Res,
    Data_in => Data_in,
    PC_out => PC_out);  

Clk_process: process begin    --100MHz clock (10ns oeriod)
    while true loop
        Clk <= '0';
        wait for 5ns;
        Clk <= '1';
        wait for 5ns;
    end loop;    
end process;

    process begin
        -- reset
        res <= '1';
        wait for 100ns;
        res <= '0'; 
        Data_in <= "101"; 
        wait for 500ns;
        
        res <= '1';
        wait for 100ns;
        res <= '0';
        Data_in <= "010"; 
        wait for 100ns;
        
        wait;
    end process;

end Behavioral;
