----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 05:13:33 PM
-- Design Name: 
-- Module Name: Nanoprocessor - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Nanoprocessor is
Port (
    Clk           : in  STD_LOGIC;
    reset         : in  STD_LOGIC;
    is_hex         : in STD_LOGIC;   -- displays hexadecimal value
    overflow_flag : out STD_LOGIC;
    zero_flag     : out STD_LOGIC;
    negative_flag : out STD_LOGIC;
    r7_led          : out std_logic_vector (7 downto 0);
    cathodes        : out std_logic_vector (6 downto 0);  -- 7-segment cathodes
    anodes        : out STD_LOGIC_VECTOR (3 downto 0)   -- 4 anodes for Basys 3
--    temp_alu_out  : out std_logic_vector(7 downto 0)
);
end Nanoprocessor;

architecture Behavioral of Nanoprocessor is

-- COMPONENT DECLARATIONS
component Slow_Clk
port( 
    clk_in : in STD_LOGIC;
    clk_out : out STD_LOGIC );
end component;

component Counter is
    Port (
        Clk      : in  STD_LOGIC;
        Res      : in  STD_LOGIC;
        Data_in  : in  STD_LOGIC_VECTOR (2 downto 0);
        PC_out   : out STD_LOGIC_VECTOR (2 downto 0)
    );
end component;


component program_rom is
    Port (
        addr     : in  STD_LOGIC_VECTOR(2 downto 0);
        data_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
end component;

-- 3-bit adder for PC increment
component adder_3bit is
    Port (
        a   : in  STD_LOGIC_VECTOR (2 downto 0);
        sum : out STD_LOGIC_VECTOR (2 downto 0)
    );
end component;

--need to change source code
component Register_Bank is
    Port (
        D        : in  STD_LOGIC_VECTOR (7 downto 0);
        Reg_Sel  : in  STD_LOGIC_VECTOR (2 downto 0);
        Clk      : in  STD_LOGIC;
        Res      : in  STD_LOGIC;
        Q0       : out STD_LOGIC_VECTOR (7 downto 0);
        Q1       : out STD_LOGIC_VECTOR (7 downto 0);
        Q2       : out STD_LOGIC_VECTOR (7 downto 0);
        Q3       : out STD_LOGIC_VECTOR (7 downto 0);
        Q4       : out STD_LOGIC_VECTOR (7 downto 0);
        Q5       : out STD_LOGIC_VECTOR (7 downto 0);
        Q6       : out STD_LOGIC_VECTOR (7 downto 0);
        Q7       : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

component Instruction_decoder is
    Port (
        instruction      : in  STD_LOGIC_VECTOR (15 downto 0);   -- ned to change
        register_check   : in  STD_LOGIC_VECTOR (7 downto 0);
        immediate_value  : out STD_LOGIC_VECTOR (7 downto 0);    -- changed
        load_select      : out STD_LOGIC;
        reg_enable       : out STD_LOGIC_VECTOR (2 downto 0);
        reg_select_A     : out STD_LOGIC_VECTOR (2 downto 0);
        reg_select_B     : out STD_LOGIC_VECTOR (2 downto 0);
        addsub_select    : out STD_LOGIC;
        jump_flag        : out STD_LOGIC;
        address_to_jump  : out STD_LOGIC_VECTOR (2 downto 0)
    );
end component;

-- Mux components for integrating
component mux_2_3 is
    Port (
        A   : in  STD_LOGIC_VECTOR (2 downto 0);
        B   : in  STD_LOGIC_VECTOR (2 downto 0);
        Sel : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR (2 downto 0)
    );
end component;

component mux_2_8 is
    Port (
        A   : in  STD_LOGIC_VECTOR (7 downto 0);
        B   : in  STD_LOGIC_VECTOR (7 downto 0);
        Sel : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

component mux_8_8 is
    Port (
        sel : in  STD_LOGIC_VECTOR(2 downto 0);
        d0  : in  STD_LOGIC_VECTOR(7 downto 0);
        d1  : in  STD_LOGIC_VECTOR(7 downto 0);
        d2  : in  STD_LOGIC_VECTOR(7 downto 0);
        d3  : in  STD_LOGIC_VECTOR(7 downto 0);
        d4  : in  STD_LOGIC_VECTOR(7 downto 0);
        d5  : in  STD_LOGIC_VECTOR(7 downto 0);
        d6  : in  STD_LOGIC_VECTOR(7 downto 0);
        d7  : in  STD_LOGIC_VECTOR(7 downto 0);
        y   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

--need to change source code
component adder_subtractor_8bit is
    Port (
        A       : in  STD_LOGIC_VECTOR (7 downto 0);
        B       : in  STD_LOGIC_VECTOR (7 downto 0);
        Sub     : in  STD_LOGIC;
        S       : out STD_LOGIC_VECTOR (7 downto 0);
        Overflow : out STD_LOGIC;
        Zero     : out STD_LOGIC;
        Negative_flag : out STD_LOGIC
    );
end component;

component display_controller is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        is_hex      : in STD_LOGIC;
        display_val : in  STD_LOGIC_VECTOR(7 downto 0);  -- Value to display (from register)
        p_count     : in STD_LOGIC_VECTOR (2 downto 0);  -- program counter value
        cathodes    : out STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment cathode signals
        anodes      : out STD_LOGIC_VECTOR(3 downto 0)   -- 4 anodes for Basys 3 display
    );
end component;


signal slow_clock : STD_LOGIC;

signal PC_out         : STD_LOGIC_VECTOR(2 downto 0);
signal PC_next        : STD_LOGIC_VECTOR(2 downto 0);
signal PC_incremented : STD_LOGIC_VECTOR(2 downto 0);
signal instruction    : STD_LOGIC_VECTOR(15 downto 0);  --need to change

-- Decoder output signals
signal immediate_value : STD_LOGIC_VECTOR(7 downto 0);    --changed
signal load_select     : STD_LOGIC;
signal reg_enable      : STD_LOGIC_VECTOR(2 downto 0);
signal reg_select_A    : STD_LOGIC_VECTOR(2 downto 0);
signal reg_select_B    : STD_LOGIC_VECTOR(2 downto 0);
signal addsub_select   : STD_LOGIC;
signal jump_flag       : STD_LOGIC;
signal address_to_jump : STD_LOGIC_VECTOR(2 downto 0);

-- Register values
signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : STD_LOGIC_VECTOR(7 downto 0);

-- ALU signals
signal A, B : STD_LOGIC_VECTOR(7 downto 0);
signal alu_out : STD_LOGIC_VECTOR(7 downto 0);
signal alu_overflow : STD_LOGIC;
signal alu_zero : STD_LOGIC;
signal alu_negative : STD_LOGIC;

-- Register Input Mux
signal reg_input : STD_LOGIC_VECTOR(7 downto 0);

-- Seven Seg
signal Data : std_logic_vector (3 downto 0);
signal Y_7seg : STD_LOGIC_VECTOR (6 downto 0);

begin
    
    Slow_Clk_0 : Slow_Clk
    port map(
        clk_in => Clk,
        clk_out => slow_clock );

    -- ROM instance
    ROM_inst : program_rom
        port map (
            addr     => PC_out,
            data_out => instruction
        );

    -- PC Increment Adder
    PC_Adder_inst : adder_3bit
        port map (
            a   => PC_out,
            sum => PC_incremented
        );

    -- PC Mux (select between incremented PC and jump address)
    PC_Mux_inst : mux_2_3
        port map (
            A   => PC_incremented,
            B   => address_to_jump,
            Sel => jump_flag,
            Y   => PC_next
        );

    -- Program Counter
    PC_inst : Counter
        port map (
            Clk     => slow_clock,
            Res     => reset,
            Data_in => PC_next,
            PC_out  => PC_out
        );

    -- Register Input Mux (select between immediate value and ALU output)
    Reg_Input_Mux_inst : mux_2_8
        port map (
            A   => alu_out,
            B   => immediate_value,
            Sel => load_select,
            Y   => reg_input
        );

    -- 8-to-1 Mux for Register A selection
    Mux_A_inst : mux_8_8
        port map (
            sel => reg_select_A,
            d0  => Q0,
            d1  => Q1,
            d2  => Q2,
            d3  => Q3,
            d4  => Q4,
            d5  => Q5,
            d6  => Q6,
            d7  => Q7,
            y   => A
        );

    -- 8-to-1 Mux for Register B selection
    Mux_B_inst : mux_8_8
        port map (
            sel => reg_select_B,
            d0  => Q0,
            d1  => Q1,
            d2  => Q2,
            d3  => Q3,
            d4  => Q4,
            d5  => Q5,
            d6  => Q6,
            d7  => Q7,
            y   => B
        );

    -- Register Bank instance
    RegBank_inst : Register_Bank
        port map (
            D       => reg_input,
            Reg_Sel => reg_enable,
            Clk     => slow_clock,
            Res     => reset,
            Q0      => Q0,
            Q1      => Q1,
            Q2      => Q2,
            Q3      => Q3,
            Q4      => Q4,
            Q5      => Q5,
            Q6      => Q6,
            Q7      => Q7
        );

    -- Decoder instance
    Decoder_inst : Instruction_decoder
        port map (
            instruction      => instruction,
            register_check   => A,  -- for zero_flag monitoring since register to be checked is from A mux_8_4
            immediate_value  => immediate_value,
            load_select      => load_select,
            reg_enable       => reg_enable,
            reg_select_A     => reg_select_A,
            reg_select_B     => reg_select_B,
            addsub_select    => addsub_select,
            jump_flag        => jump_flag,
            address_to_jump  => address_to_jump
        );

    -- ALU (Add/Subtract) instance
    ALU_inst : adder_subtractor_8bit
        port map (
            A        => A,
            B        => B,
            Sub      => addsub_select,
            S        => alu_out,
            Overflow => alu_overflow,
            Zero     => alu_zero,
            Negative_flag => alu_negative
        );
        
      Display_Controller_inst : Display_Controller
        port map (
            clk         => Clk,          -- Use main clock for display refresh
            reset       => reset,
            is_hex      => is_hex,
            display_val => Q7,           -- Display value from register R7
            p_count     => PC_out,       -- display program count
            cathodes    => cathodes,     -- Connect to output cathodes
            anodes      => anodes        -- Connect to output anodes
        );


    -- Final Output Assignments
    overflow_flag <= alu_overflow;
    zero_flag     <= alu_zero;
    negative_flag <= alu_negative;
    r7_led       <= Q7;
--    temp_alu_out <= alu_out;
    
end Behavioral;