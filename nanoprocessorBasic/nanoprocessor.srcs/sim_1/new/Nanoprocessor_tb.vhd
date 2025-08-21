----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 05:58:14 PM
-- Design Name: 
-- Module Name: Nanoprocessor_tb - Behavioral
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

entity Nanoprocessor_tb is
end Nanoprocessor_tb;

architecture Behavioral of Nanoprocessor_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component Nanoprocessor
    Port (
        Clk           : in  STD_LOGIC;
        reset         : in  STD_LOGIC;
        overflow_flag : out STD_LOGIC;
        zero_flag     : out STD_LOGIC;
        r7_led          : out std_logic_vector (3 downto 0);
        Y_sev_seg        : out std_logic_vector (6 downto 0)
    );
    end component;
    
    -- Clock period definitions
    constant clk_period : time := 10 ns;
    
    -- Inputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    
    -- Outputs
    signal overflow_flag : std_logic;
    signal zero_flag : std_logic;
    signal r7_led : std_logic_vector (3 downto 0);
    signal Y_sev_seg : std_logic_vector (6 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Nanoprocessor 
    port map (
        Clk => clk,
        reset => reset,
        overflow_flag => overflow_flag,
        zero_flag => zero_flag,
        r7_led => r7_led,
        Y_sev_seg => Y_sev_seg
    );

    -- Clock process definitions
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- Hold reset state for 100 ns
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        
        -- Wait for 10 clock cycles to see the processor in action
        wait for clk_period*10;
        
--        -- Insert another reset to see if the processor restarts correctly
--        reset <= '1';
--        wait for clk_period*2;
--        reset <= '0';
        
        -- Continue execution for more cycles
        wait for clk_period*20;
        
        -- End simulation
        wait;
    end process;
    
    -- Monitor process to display the outputs
    monitor_proc: process(clk)
    begin
        if rising_edge(clk) then
            report "Time: " & time'image(now) & 
                   " | Output: " & integer'image(to_integer(unsigned(r7_led))) & 
                   " | Zero flag: " & std_logic'image(zero_flag) & 
                   " | Overflow flag: " & std_logic'image(overflow_flag);
        end if;
    end process;

end Behavioral;