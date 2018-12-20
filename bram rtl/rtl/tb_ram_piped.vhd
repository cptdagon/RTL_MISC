library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.cnt1_package.all;
library xgates;

entity tb_ram_piped is 
end tb_ram_piped;

architecture exercise of tb_ram_piped is 
	constant clk_period : time := 10 ns;
	constant c2q : time := clk_period/4;
	constant LOCATIONS : integer := 1024;
	
	component ram_piped
		generic (LOCATIONS : integer := 1024 ; WIDTH : integer := 32);
	port (
		clk : in std_logic;
		reset : in std_logic;
		wein : in std_logic;
		addrin : in std_logic_vector(log2(LOCATIONS)-1 downto 0);
		p_din : in std_logic_vector(WIDTH-1 downto 0);
		p_dout : out std_logic_vector(WIDTH-1 downto 0)
);
end component;

for all: ram_piped use entity xgates.ram_piped;

	signal clk_i : std_logic;
	signal reset_i : std_logic ;
	signal wein_i : std_logic;
	signal addrin_i : std_logic_vector(log2(LOCATIONS)-1 downto 0);
	signal p_din_i : std_logic_vector(32-1 downto 0);
	signal p_dout_i : std_logic_vector(32-1 downto 0);
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

		DUT : ram_piped generic map(
			WIDTH => 32,
			LOCATIONS => LOCATIONS)
	port map(
		clk => clk_i,
		addrin => addrin_i,
		p_din => p_din_i,
		p_dout => p_dout_i, 
		wein => wein_i,
		reset => reset_i
);
		stimulus_proc : process
			begin
				p_din_i <= (others => '0');
				wein_i <= '0';
				addrin_i <= (others => '0');
				wait for clk_period*10;
				--wait for clk_period/2;


for i in 0 to LOCATIONS-1 loop
				wein_i <= '1';
				addrin_i <= conv_std_logic_vector(i, log2(LOCATIONS));
				p_din_i <= conv_std_logic_vector(16#deadbeef# +i, 32);
				
				wait for clk_period*2;
				
				end loop;
				
				p_din_i <= (others => '0');
				wein_i <= '0';
				addrin_i <= (others => '0');
				
for i in 0 to LOCATIONS-1 loop
				wein_i <= '0';
				addrin_i <= conv_std_logic_vector(i, log2(LOCATIONS));
				
				
				wait for clk_period*2;
				
				end loop;


	assert (false)
		report "sim end"
		severity failure;
end process;
end exercise;	
				
