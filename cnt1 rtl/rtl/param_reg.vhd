library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity param_reg is
Generic (WIDTH : integer :=8 );
port (
	clk : in std_logic;
	reset : in std_logic;
	D : in std_logic_vector (WIDTH-1 downto 0);
	Q : out std_logic_vector (WIDTH-1 downto 0)
);
end param_reg;

architecture rtl of param_reg is 
	begin
		clk_proc : process (clk , reset)
		begin
			if reset = '1' then
				Q <= (others => '0');
			Elsif rising_edge(clk) then
				Q <= D;
		end if;
	end process;
end rtl;
