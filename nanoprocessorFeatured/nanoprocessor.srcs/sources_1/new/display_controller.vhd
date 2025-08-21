library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Display_Controller is
    Port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        is_hex      : in  STD_LOGIC;                     -- 0: signed decimal, 1: hexadecimal
        display_val : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit value to display (was 3 downto 0)
        p_count     : in  STD_LOGIC_VECTOR(2 downto 0); -- program counter value
        cathodes    : out STD_LOGIC_VECTOR(6 downto 0); -- 7-segment cathode signals
        anodes      : out STD_LOGIC_VECTOR(3 downto 0)  -- 4 anodes for Basys 3 display
    );
end Display_Controller;

architecture Behavioral of Display_Controller is

-- LUT for seven-segment patterns (common anode - active low)
type rom_type is array (0 to 15) of std_logic_vector(6 downto 0);
signal sevenSegment_ROM : rom_type := (
    "1000000", -- 0
    "1111001", -- 1
    "0100100", -- 2
    "0110000", -- 3
    "0011001", -- 4
    "0010010", -- 5
    "0000010", -- 6
    "1111000", -- 7
    "0000000", -- 8
    "0010000", -- 9
    "0001000", -- A (10)
    "0000011", -- B (11)
    "1000110", -- C (12)
    "0100001", -- D (13)
    "0000110", -- E (14)
    "0001110"  -- F (15)
);

-- Special characters
constant NEGATIVE_SIGN : std_logic_vector(6 downto 0) := "0111111"; -- minus sign
constant BLANK_DISPLAY : std_logic_vector(6 downto 0) := "1111111"; -- all segments off

-- Clock and control signals
signal refresh_clk : STD_LOGIC := '0';
signal display_select : STD_LOGIC_VECTOR(1 downto 0) := "00";

-- 8-bit value processing signals
signal is_negative : STD_LOGIC;
signal abs_value : STD_LOGIC_VECTOR(7 downto 0);
signal decimal_value : integer range 0 to 255;

-- Decimal digit extraction (for signed decimal mode)
signal hundreds_digit : integer range 0 to 2;
signal tens_digit : integer range 0 to 9;
signal ones_digit : integer range 0 to 9;

-- Hexadecimal digit extraction (for hex mode)
signal hex_upper : STD_LOGIC_VECTOR(3 downto 0);
signal hex_lower : STD_LOGIC_VECTOR(3 downto 0);

begin

-- Clock divider for display refresh (~1kHz)
    process(clk)
    variable count : integer range 0 to 50000 := 0;
    begin
        if rising_edge(clk) then
            if count = 50000 then  -- Assuming 100MHz clock, gives ~2kHz refresh
                count := 0;
                refresh_clk <= not refresh_clk;
            else
                count := count + 1;
            end if;
        end if;
    end process;
    
    -- Display selector counter (cycles through the 4 displays)
    process(refresh_clk, reset)
    begin
        if reset = '1' then
            display_select <= "00";
        elsif rising_edge(refresh_clk) then
            display_select <= display_select + 1;
        end if;
    end process;
    
    -- Process 8-bit input value
    process(display_val)
    variable temp_decimal : integer;
    begin
        -- Check if value is negative (MSB = 1 in two's complement)
        is_negative <= display_val(7);
        
        -- Get absolute value for decimal display
        if display_val(7) = '1' then
            -- Negative: take two's complement
            abs_value <= std_logic_vector(unsigned(not display_val) + 1);
        else
            -- Positive: use as-is
            abs_value <= display_val;
        end if;
        
        -- Convert to decimal (0-128 range for signed)
        decimal_value <= to_integer(unsigned(abs_value));
        
        -- Extract decimal digits (for values 0-128)
        temp_decimal := decimal_value;
        ones_digit <= temp_decimal mod 10;
        temp_decimal := temp_decimal / 10;
        tens_digit <= temp_decimal mod 10;
        temp_decimal := temp_decimal / 10;
        hundreds_digit <= temp_decimal mod 10;
        
        -- Extract hex digits
        hex_lower <= display_val(3 downto 0);  -- Lower 4 bits
        hex_upper <= display_val(7 downto 4);  -- Upper 4 bits
    end process;
    
    -- Display multiplexing logic
    process(display_select, is_hex, is_negative, hundreds_digit, tens_digit, ones_digit, 
            hex_upper, hex_lower, p_count)
    begin
        -- Default state (all displays off)
        anodes <= "1111";  -- All anodes inactive (common anode, so '1' is off)
        cathodes <= BLANK_DISPLAY;  -- All segments off
        
        case display_select is
            when "00" =>
                -- Display 0 (rightmost): Ones digit or lower hex digit
                anodes <= "1110";
                if is_hex = '1' then
                    -- Hex mode: show lower 4 bits
                    cathodes <= sevenSegment_ROM(to_integer(unsigned(hex_lower)));
                else
                    -- Decimal mode: show ones digit
                    cathodes <= sevenSegment_ROM(ones_digit);
                end if;
                
            when "01" =>
                -- Display 1: Tens digit or upper hex digit
                anodes <= "1101";
                if is_hex = '1' then
                    -- Hex mode: show upper 4 bits
                    cathodes <= sevenSegment_ROM(to_integer(unsigned(hex_upper)));
                else
                    -- Decimal mode: show tens digit (or blank if zero and no hundreds)
                    if tens_digit = 0 and hundreds_digit = 0 and is_negative = '0' then
                        cathodes <= BLANK_DISPLAY;
                    else
                        cathodes <= sevenSegment_ROM(tens_digit);
                    end if;
                end if;
                
            when "10" =>
                -- Display 2: Hundreds digit or hex prefix or sign
                anodes <= "1011";
                if is_hex = '1' then
                    -- Hex mode: could show 'H' or be blank for standard hex display
                    cathodes <= BLANK_DISPLAY;  -- Standard hex doesn't need prefix on display
                else
                    -- Decimal mode: show hundreds digit or negative sign
                    if is_negative = '1' then
                        cathodes <= NEGATIVE_SIGN;
                    elsif hundreds_digit = 0 then
                        cathodes <= BLANK_DISPLAY;
                    else
                        cathodes <= sevenSegment_ROM(hundreds_digit);
                    end if;
                end if;
                
            when "11" =>
                -- Display 3 (leftmost): Program counter
                anodes <= "0111";
                cathodes <= sevenSegment_ROM(to_integer(unsigned(p_count)));
                
            when others =>
                anodes <= "1111";
                cathodes <= BLANK_DISPLAY;
        end case;
    end process;
    
end Behavioral;
