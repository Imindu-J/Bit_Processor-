
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Nanoprocessor_TB is
-- Empty entity for testbench
end Nanoprocessor_TB;

architecture Behavioral of Nanoprocessor_TB is

    -- Component Declaration for the Unit Under Test (UUT)
    component Nanoprocessor is
        Port (
            Clk           : in  STD_LOGIC;
            reset         : in  STD_LOGIC;
            is_hex         : in STD_LOGIC;   -- displays hexadecimal value
            overflow_flag : out STD_LOGIC;
            zero_flag     : out STD_LOGIC;
            negative_flag : out STD_LOGIC;
            r7_led        : out std_logic_vector (7 downto 0);
            cathodes      : out std_logic_vector (6 downto 0);
            anodes        : out STD_LOGIC_VECTOR (3 downto 0)
--            temp_alu_out  : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- Clock signal
    signal Clk : STD_LOGIC := '0';
    
    -- Reset signal
    signal reset : STD_LOGIC := '1';  -- Active high reset
    
    -- Output signals
    signal is_hex : STD_LOGIC := '0';
    signal overflow_flag : STD_LOGIC := '0';
    signal zero_flag : STD_LOGIC;
    signal negative_flag : STD_LOGIC := '0';
    signal r7_led : STD_LOGIC_VECTOR(7 downto 0);
    signal cathodes : STD_LOGIC_VECTOR(6 downto 0);
    signal anodes : STD_LOGIC_VECTOR(3 downto 0);
--    signal temp_alu_out : STD_LOGIC_VECTOR(7 downto 0);
    
    -- Clock period definition
    constant Clk_period : time := 10 ns;
    
    -- Simulation end time
    constant sim_end : time := 2000 ns;
    
begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Nanoprocessor
        port map (
            Clk => Clk,
            reset => reset,
            is_hex => is_hex,
            overflow_flag => overflow_flag,
            zero_flag => zero_flag,
            negative_flag => negative_flag,
            r7_led => r7_led,
            cathodes => cathodes,
            anodes => anodes
--            temp_alu_out => temp_alu_out
        );
    
    -- Clock process
    Clk_process: process
    begin
        while now < sim_end loop
            Clk <= '0';
            wait for Clk_period/2;
            Clk <= '1';
            wait for Clk_period/2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- Hold reset state for 100 ns
        reset <= '1';
        wait for 100 ns;
        
        -- Release reset
        reset <= '0';
        
        -- Wait and observe operation
        wait for sim_end;
        
        -- End simulation
        assert false report "Simulation Ended" severity failure;
        wait;
    end process;
    
    -- Monitor process to display register values and flags
    monitor_proc: process
    begin
        wait for 100 ns; -- Wait for reset to be released
        
        while now < sim_end loop
            wait for Clk_period*10; -- Check values every 10 clock cycles
            
            report "Time: " & integer'image(integer(now / 1 ns)) & " ns" &
                  ", Register R7: " & integer'image(to_integer(unsigned(r7_led))) &
                  ", Zero Flag: " & std_logic'image(zero_flag) &
                  ", Overflow Flag: " & std_logic'image(overflow_flag);
        end loop;
        
        wait;
    end process;

end Behavioral;