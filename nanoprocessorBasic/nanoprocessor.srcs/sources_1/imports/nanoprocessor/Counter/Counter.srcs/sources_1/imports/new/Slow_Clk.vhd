library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Slow_Clk is
    Port (
        clk_in  : in  STD_LOGIC;  -- 100 MHz input
        clk_out : out STD_LOGIC   -- ~1.49 Hz output
    );
end Slow_Clk;

architecture Behavioral of Slow_Clk is
    signal counter : unsigned(25 downto 0) := (others => '0');
--    signal counter : unsigned(2 downto 0) := (others => '0');   -- for simulation
    
        -- Hint synthesis to use DSP for this signal
    attribute use_dsp : string;
    attribute use_dsp of counter : signal is "yes";

begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            counter <= counter + 1;
        end if;
    end process;

    clk_out <= counter(25);  -- MSB of counter toggles ~1.49 Hz
--    clk_out  <= counter(2);  --for simulation
end Behavioral;

