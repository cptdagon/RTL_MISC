library ieee;
use ieee.std_logic_1164.all;



entity regen is
	generic (
		width : integer := 8
);
	port (
		clk : in std_logic;
		reset : in std_logic;
		d : in std_logic_vector(width - 1 downto 0);
		q : out std_logic_vector(width - 1 downto 0);
		en : in std_logic
);
end regen;

architecture struct of regen is

	-- Declare Components
	component ffen
	
	
	port(
		clk,reset,d,en : in std_logic;
		q : out std_logic
);

end component;--regen;



begin
	GEN_REGEN :
		for i in 0 to width - 1 generate
			I_FFEN : ffen port map (
				clk	=>	clk,
				reset	=>	reset,
				d	=>	d(i),
				q	=>	q(i),
				en 	=> 	en
);				
end generate;
end struct;
