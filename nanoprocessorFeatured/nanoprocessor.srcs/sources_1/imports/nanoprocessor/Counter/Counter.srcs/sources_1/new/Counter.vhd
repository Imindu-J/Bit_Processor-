library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
    Port ( Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Data_in : in STD_LOGIC_VECTOR (2 downto 0);
           PC_out : out STD_LOGIC_VECTOR (2 downto 0));
end Counter;

architecture Behavioral of Counter is

signal PC : std_logic_vector(2 downto 0);

begin

process (Clk, Res)
begin    
    if rising_edge(Clk) then
        if Res = '1' then
            PC <= "000";
        else
            PC <= Data_in;
        end if;
    end if;
end process;

PC_out <= PC;

end Behavioral;
