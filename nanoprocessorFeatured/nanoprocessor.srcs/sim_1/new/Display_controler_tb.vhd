library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display_Controller_tb is
end Display_Controller_tb;

architecture Behavioral of Display_Controller_tb is

    -- Component Declaration
    component Display_Controller
        Port (
            clk         : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            is_hex      : in  STD_LOGIC;
            display_val : in  STD_LOGIC_VECTOR(7 downto 0);
            p_count     : in  STD_LOGIC_VECTOR(2 downto 0);
            cathodes    : out STD_LOGIC_VECTOR(6 downto 0);
            anodes      : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Testbench signals
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal is_hex      : STD_LOGIC := '0';
    signal display_val : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal p_count     : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal cathodes    : STD_LOGIC_VECTOR(6 downto 0);
    signal anodes      : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate Unit Under Test (UUT)
    uut: Display_Controller
        Port map (
            clk         => clk,
            reset       => reset,
            is_hex      => is_hex,
            display_val => display_val,
            p_count     => p_count,
            cathodes    => cathodes,
            anodes      => anodes
        );

    -- Clock generation: 100 MHz
    clk_process :process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Test 1: Decimal mode, display +45
        is_hex <= '0';
--        display_val <= std_logic_vector(to_signed(45, 8));
        display_val <= "01100100";
        p_count <= "001";
        wait for 100 ms;

        -- Test 2: Decimal mode, display -87
        display_val <= "10101001";  -- -87 in 2's complement
        p_count <= "011";
        wait for 100 ms;

        -- Test 3: Hex mode, display 0xAB
        is_hex <= '1';
        display_val <= "10101011";  -- 0xAB
        p_count <= "101";
        wait for 100 ms;

        -- Test 4: Hex mode, display 0x00
        display_val <= "00000000";
        p_count <= "111";
        wait for 100 ms;

        -- Test 5: Decimal mode, display -128
        is_hex <= '0';
        display_val <= "10000000";  -- -128 in 2's complement
        wait for 100 ms;

        wait;
    end process;

end Behavioral;
