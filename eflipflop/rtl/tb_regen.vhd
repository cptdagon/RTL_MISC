library ieee;
--library xgates;
use ieee.std_logic_1164.all;

entity tb_regen is

end tb_regen;

architecture exercise of tb_regen is 
constant clk_period : time := 10 ns;	
constant c2q : time := clk_period/4;
	--Declare components
		component regen
			generic(
				width : integer := 8
);
		port(
			clk : in std_logic;
			reset : in std_logic;
			d : in std_logic_vector(width - 1 downto 0);
			q : out std_logic_vector(width - 1 downto 0);
			en : in std_logic
);
end component;

--for all:regen use entity xgates.regen;

	--Declare internal signals
		signal clk_i : std_logic;
		signal reset_i : std_logic;
		signal d_i : std_logic_vector(7 downto 0);
		signal q_i : std_logic_vector(7 downto 0);
		signal en_i : std_logic;

	begin

		reset_me : process
			begin
			wait for c2q;
			reset_i <= '1';
			wait for clk_period;
			reset_i <= '0';
			wait;
end process;

		clk_me : process
			begin
			clk_i <= '1';
			wait for clk_period/2;
			clk_i <= '0';
			wait for clk_period/2; 
end process;

			
--Instantiate design-under-test
		DUT : regen generic map(
			width => 8
)
		port map(
			clk	=>	clk_i,
			reset	=>	reset_i,
			d	=>	d_i,
			q	=>	q_i,
			en 	=> 	en_i
);
		

	stimulus_proc : process
		begin
			--verify port d(3:0) operation
			--default assignments
			
			d_i <= (others=>'0');
			wait for clk_period*10;
			wait for clk_period/2;
			en_i <= '0';
		for i in 0 to 7 loop
			-- drive d
			d_i(i) <= '1';
			
			wait for clk_period*4;
			--test q
			assert (q_i = q_i)
				report "q_i differs from d_i"
					severity failure;
end loop;

	
			--verify port d(3:0) operation
			--default assignments
			
			d_i <= (others=>'0');
			
			en_i <= '1';
		for i in 0 to 7 loop
			 --drive d
			d_i(i) <= '1';
			
			wait for clk_period*4;
			--test q
			assert (q_i = d_i)
				report "q_i differs from q_i"
					severity failure;
end loop;

--terminate simulation
	assert (false)
		report "simulation end"
		severity failure;
	end process;
end exercise;
