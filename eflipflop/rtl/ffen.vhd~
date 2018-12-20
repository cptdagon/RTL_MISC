library ieee;
use ieee.std_logic_1164.all;

entity ffen is
	port (
		clk : in std_logic;
		reset : in std_logic;
		en : in std_logic;
		d : in std_logic;
		q : out std_logic
);
end ffen;

architecture struct of ffen is
	signal n4 : std_logic;
	signal n5 : std_logic;

	component mux2_1
	port (
		A : in std_logic;
		B : in std_logic;
		sel : in std_logic;
		Z : out std_logic
);
end component;

	component dff
	port (
		clk : in std_logic;
		reset : in std_logic;
		d : in std_logic;
		q : out
		
		
		 std_logic
);
end component;

	begin 
		I_MUX : mux2_1 port map (
			Z => n4,
			a => n5,
			b => d ,
			sel => en
);
		I_DFF : dff port map (
			d => n4,
			q => n5,
			reset => reset,
			clk => clk
);
q <= n5;
end struct;
