Library ieee;
Library xgates;
Use ieee.std_logic_1164.all;
Entity tb_mux2_multibit is 

end tb_mux2_multibit;

	architecture exercise of tb_mux2_multibit is
	-- Declare components
		component mux2_multibit
		generic (
			width: integer :=4
);
		port(
			A : std_logic_vector(width - 1 downto 0);
			B : std_logic_vector(width - 1 downto 0);
			sel : in std_logic;
			Z : out std_logic_vector(width - 1 downto 0)
);
end component;

for all:mux2_multibit use entity xgates.mux2_multibit;

	-- Declare internal signals
		signal A_i : std_logic_vector(3 downto 0);
		signal B_i : std_logic_vector(3 downto 0);
		signal Z_i : std_logic_vector(3 downto 0);
		signal sel_i : std_logic;
	begin

	-- Instantiate design-under-test
	DUT : mux2_multibit generic map (
		width => 4
)
	port map (
		A	=>	A_i,
		B	=>	B_i,
		sel	=>	sel_i,
		Z	=>	Z_i
);

	stimulus_proc : process
		begin
			-- verify port A(3:0) operation
			-- Default assignments
			B_i <= "1111";
			sel_i <= '0';
		for i in 0 to 3 loop
			-- Drive A
			A_i <= (others => '0');
			A_i(i) <= '1';
			wait for 10 ns;
			-- Test Z
			assert (Z_i = A_i)
				report "Z_i differs from A_i"
				severity failure;
end loop;

	
			-- verify port B(3:0) operation
			-- Default assignments
			A_i <= "1111";
			sel_i <= '1';
		for i in 0 to 3 loop
			-- Drive B
			B_i <= (others => '0');
			B_i(i) <= '1';
			wait for 10 ns;
			-- Test Z
			assert (Z_i = B_i)
				report "Z_i differs from B_i"
				severity failure;
end loop;

	-- Terminate siulation
	assert (false)
		report "SIMULATION END"
		severity failure;
		
	end process;
end exercise; 

