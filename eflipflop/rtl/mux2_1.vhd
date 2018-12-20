Library ieee;
Use ieee.std_logic_1164.all;

Entity mux2_1 is
port (
	A : in std_logic;
	B : in std_logic;
	sel : in std_logic;
	Z : out std_logic
);
end mux2_1;

	architecture struct of mux2_1 is
	signal n1 : std_logic;
	signal n2 : std_logic;
	signal n3 : std_logic;

	component and2
	port (
		A : in std_logic;
		B : in std_logic;
		Z : out std_logic
);
end component;

	component or2
	port (
		A : in std_logic;
		B : in std_logic;
		Z : out std_logic
);
end component;

	component inv
	port ( 
		A : in std_logic;
		Z : out std_logic
);
end component;

	begin
		I_INV1 : inv port map (
			A => sel,
			Z => n1
);
		I_AND1 : and2 port map (
			A => n1,
			B => A,
			Z => n2
);
		I_AND2 : and2 port map (
			A => sel,
			B => B,
			Z => n3
);
		I_OR1 : or2 port map (
			A => n2,
			B => n3,
			Z => Z
);
end struct;
