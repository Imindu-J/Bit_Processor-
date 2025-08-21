library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register_Bank is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           Reg_Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           Res : in STD_LOGIC; 
           Q0 : out STD_LOGIC_VECTOR (7 downto 0);
           Q1 : out STD_LOGIC_VECTOR (7 downto 0);
           Q2 : out STD_LOGIC_VECTOR (7 downto 0);
           Q3 : out STD_LOGIC_VECTOR (7 downto 0);
           Q4 : out STD_LOGIC_VECTOR (7 downto 0);
           Q5 : out STD_LOGIC_VECTOR (7 downto 0);
           Q6 : out STD_LOGIC_VECTOR (7 downto 0);
           Q7 : out STD_LOGIC_VECTOR (7 downto 0)
           );
end Register_Bank;

architecture Behavioral of Register_Bank is

component Reg_with_Reset
    port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Decoder_3_to_8
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;


signal R: STD_LOGIC_VECTOR (7 downto 0);

begin
Decoder_3_to_8_0 : Decoder_3_to_8
    port map(
    I => Reg_Sel,
    EN => '1',
    Y => R);

R0 : Reg_with_Reset
    port map(
    D => "00000000",
    En => R(0),
    Clk => Clk,
    Reset => Res,
    Q => Q0);
    
R1 : Reg_with_Reset
    port map(
    D => D,
    En => R(1),
    Clk => Clk,
    Reset => Res,
    Q => Q1);

R2 : Reg_with_Reset
    port map(
    D => D,
    En => R(2),
    Clk => Clk,
    Reset => Res,
    Q => Q2);
    
R3 : Reg_with_Reset
    port map(
    D => D,
    En => R(3),
    Clk => Clk,
    Reset => Res,
    Q => Q3);
        
R4 : Reg_with_Reset
    port map(
    D => D,
    En => R(4),
    Clk => Clk,
    Reset => Res,
    Q => Q4);   
            
R5 : Reg_with_Reset
    port map(
    D => D,
    En => R(5),
    Clk => Clk,
    Reset => Res,
    Q => Q5);
                
R6 : Reg_with_Reset
    port map(
    D => D,
    En => R(6),
    Clk => Clk,
    Reset => Res,
    Q => Q6);  

R7 : Reg_with_Reset
    port map(
    D => D,
    En => R(7),
    Clk => Clk,
    Reset => Res,
    Q => Q7);   
    
end Behavioral;
