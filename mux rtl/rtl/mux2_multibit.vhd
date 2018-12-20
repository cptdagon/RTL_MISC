Library ieee;
Use ieee.std_logic_1164.all;
Entity mux2_multibit is
	generic (
		width : integer := 32
);
	port (
		A : in std_logic_vector(width -1 downto 0);
		B : in std_logic_vector(width -1 downto 0);
		sel : in std_logic;
		Z : out std_logic_vector(width -1 downto 0 )
);
end;

	architecture struct of mux2_multibit is
		-- declare components
		component mux2_1
		port (
			A, B, sel : in std_logic;
			Z : out std_logic
);
end component; --mux2_1;

	begin
		GEN_MUX :
			for i in 0 to width - 1 generate
				I_MUX2_1 : mux2_1 port map (
					A	=>	A(i),
					B	=>	B(i),
					sel	=>	sel,
					Z	=>	Z(i)
);
end generate;
end struct;
