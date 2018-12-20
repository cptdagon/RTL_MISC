library ieee;
Library xgates;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.cnt1_package.all;

entity tb_cnt1 is

end tb_cnt1;

architecture exercise of tb_cnt1 is
	constant clk_period : time := 10 ns;
	constant c2q : time := clk_period/4;
	
	component cnt1
		generic (
			WIDTH : integer := 8
);
	port (	
		clk : in std_logic;
		reset : in std_logic;
		ones_r : out std_logic_vector(log2(W) +1 - 1 downto 0);
		a : in std_logic_vector(width - 1 downto 0)
);
end component;

for all:cnt1 use entity xgates.cnt1;
 
		signal clk_i : std_logic;
		signal reset_i : std_logic;
		signal a_i : std_logic_vector(W-1 downto 0);
		signal ones_r_i : std_logic_vector(log2(W)+1 -1 downto 0);
		
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

		DUT : cnt1 generic map (
			WIDTH => W
)
		port map (
			clk 	=> 	clk_i,
			reset	=>	reset_i,
			a	=> 	a_i,
			ones_r	=>	ones_r_i
);

	stimulus_proc : process
		begin
			--verify port a(7:0) operation
			--default assignments
			a_i <= (others=>'0');
			wait for clk_period*4;
		for i in 0 to 7 loop
			-- drive a
			a_i(i) <= '1';
			wait for clk_period*4;
end loop;

--terminate simulation
	assert (false)
		report "simulation end"
		severity failure;
	end process;
end exercise;
