----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 05:14:18 PM
-- Design Name: 
-- Module Name: tb_program_rom - Behavioral
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

entity rom_tb is
    -- Empty entity for testbench
end rom_tb;

architecture sim of rom_tb is
    -- Signals
    signal address : std_logic_vector(2 downto 0);
    signal instruction : std_logic_vector(11 downto 0);
    
    -- Component declaration for the ROM
    component program_rom
        port (
            addr     : in  std_logic_vector(2 downto 0);
            data_out : out std_logic_vector(11 downto 0)
        );
    end component;
    
begin
    -- Instantiate the ROM component
    ROM: program_rom port map (
        addr => address,
        data_out => instruction
    );
    
    -- Simple test process that cycles through all addresses
    stim_proc: process
    begin
        -- Test each address
        address <= "000"; wait for 10 ns;
        assert instruction = "100000000101" report "Error at address 000" severity error;
        
        address <= "001"; wait for 10 ns;
        assert instruction = "100010000011" report "Error at address 001" severity error;
        
        address <= "010"; wait for 10 ns;
        assert instruction = "000000001000" report "Error at address 010" severity error;
        
        address <= "011"; wait for 10 ns;
        assert instruction = "010000000000" report "Error at address 011" severity error;
        
        address <= "100"; wait for 10 ns;
        assert instruction = "110010000111" report "Error at address 100" severity error;
        
        address <= "101"; wait for 10 ns;
        assert instruction = "100100000001" report "Error at address 101" severity error;
        
        address <= "110"; wait for 10 ns;
        assert instruction = "000010010000" report "Error at address 110" severity error;
        
        address <= "111"; wait for 10 ns;
        assert instruction = "110010000010" report "Error at address 111" severity error;
        
        -- End simulation
        report "Simulation completed successfully";
        wait;
    end process;

end sim;