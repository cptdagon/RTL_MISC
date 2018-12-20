library ieee;
use ieee.std_logic_1164.all;

entity reg is
	generic (
		width : integer := 4
);
	port (
		clk : in std_logic;
		reset : in std_logic;
		d : in std_logic_vector(width - 1 downto 0);
		q : out std_logic_vector(width - 1 downto 0)
);
end reg;

architecture struct of reg is
	-- Declare Components
	component dff
	port(
		clk,reset,d : in std_logic;
		q : out std_logic
);
end component;--reg;

begin
	GEN_REG :
		for i in 0 to width - 1 generate
			I_DFF : dff port map (
				clk	=>	clk,
				reset	=>	reset,
				d	=>	d(i),
				q	=>	q(i)
);
end generate;
end struct;
