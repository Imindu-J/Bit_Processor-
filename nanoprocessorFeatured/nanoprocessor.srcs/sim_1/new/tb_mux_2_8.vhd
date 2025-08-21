library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux_2_8 is
-- No ports in test bench entity
end tb_mux_2_8;

architecture behavior of tb_mux_2_8 is

    -- Component Declaration of the Unit Under Test (UUT)
    component mux_2_8
        Port (
            A   : in STD_LOGIC_VECTOR(7 downto 0);
            B   : in STD_LOGIC_VECTOR(7 downto 0);
            Sel : in STD_LOGIC;
            Y   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal A   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal B   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Sel : STD_LOGIC := '0';
    signal Y   : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: mux_2_8 Port Map (
        A   => A,
        B   => B,
        Sel => Sel,
        Y   => Y
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1: Sel = 0, output should be A
        A <= "00000011"; -- 3
        B <= "11110000"; -- 240
        Sel <= '0';
        wait for 10 ns;

        -- Test Case 2: Sel = 1, output should be B
        Sel <= '1';
        wait for 10 ns;

        -- Test Case 3: Change inputs
        A <= "10101010"; -- 170
        B <= "01010101"; -- 85
        Sel <= '0';
        wait for 10 ns;

        Sel <= '1';
        wait for 10 ns;

        -- Test Case 4: Edge values
        A <= "11111111"; -- 255
        B <= "00000000"; -- 0
        Sel <= '0';
        wait for 10 ns;

        Sel <= '1';
        wait for 10 ns;

        wait;
    end process;

end behavior;
