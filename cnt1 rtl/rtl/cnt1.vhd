library ieee;
use ieee.std_logic_1164.all;
use work.cnt1_package.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cnt1 is 
Generic (Width : integer := W);
port (
	clk : in std_logic;
	reset : in std_logic;
	a : in std_logic_vector (W-1 downto 0);
	ones_r : out std_logic_vector (log2(W) +1 - 1 downto 0)
);
end cnt1;

architecture struct of cnt1 is
	signal a_r : std_logic_vector (W-1 downto 0);
	signal ones_i : std_logic_vector (log2(W)+1-1 downto 0);
	
	component param_reg 
	generic (WIDTH : integer := 8);
	port(
		clk, reset : in std_logic;
		d : in std_logic_vector(Width -1 downto 0);
		q : out std_logic_vector(width -1 downto 0)
);
end component;
	
begin
	I_reg1 : param_reg generic map (
		WIDTH => W
)
	port map (
		clk => clk,
		reset => reset,
		d => a,
		q => a_r
);
	I_reg2 : param_reg generic map (
		WIDTH => log2(W)+1
)
	port map (
		clk => clk,
		reset => reset,
		d => ones_i,
		q => ones_r
);
	cnt1_PROC : process (a_r)
		variable cnt_I : integer := 0;
begin
	cnt_I := 0;
	for i in W-1 downto 0 loop
		If (a_r(i)) = '1' then
			cnt_I := cnt_I + 1;
		end if;
	end loop;
	
ones_i <= conv_std_logic_vector (cnt_I , log2(W) + 1);
end process;

end struct;
