library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.cnt1_package.all;

entity tb_fsm is
end tb_fsm;

architecture exercise of tb_fsm is
	constant clk_period : time := 10 ns;
	constant c2q : time := clk_period/4;
	constant LOCATIONS : integer := 1024;
	
	component memory_controller is
	generic (LOCATIONS : integer := 1024 ; WIDTH : integer := 32);
	port(
		clk	:	in std_logic;
		reset	:	in std_logic;
		req	:	in std_logic;
		addr	:	in std_logic_vector(log2(LOCATIONS)-1 downto 0);--31 downto 0);
		burst	:	in std_logic_vector(3 downto 0);
		rdy	:	out std_logic;
		c_dout	:	out std_logic_vector(31 downto 0);
		
		we	: 	in std_logic
);
end component;

	signal clk_i	:	std_logic;
	signal reset_i	:	std_logic;
	signal req_i	:	std_logic;
	signal addr_i	:	std_logic_vector(log2(LOCATIONS)-1 downto 0);--31 downto 0);
	signal burst_i	:	std_logic_vector(3 downto 0);
	signal rdy_i	:	std_logic;
	signal c_dout_i	:	std_logic_vector(31 downto 0);
	signal memdin_i	:	std_logic_vector(31 downto 0);
	signal we_i	: 	std_logic;
	
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

		DUT : memory_Controller generic map(
			WIDTH => 32,
			LOCATIONS => LOCATIONS)
		
	port map(
		clk => clk_i,
		reset => reset_i,
		req => req_i,
		addr => addr_i,
		burst => burst_i,
		rdy => rdy_i,
		c_dout => c_dout_i,
		--m_din => m_din_i,
		
		we => we_i
);		
		stimulus_proc : process
			begin
			-- start by writing data to the memory before trying to access memory via fsm
			-- do so for address 3 downto 0. then start calling memory item	
				we_i <= '0';
				req_i <= '0';
				addr_i <= (others => '0');
				burst_i <= (others => '0');
				
				wait for clk_period*2;
				
for i in 0 to 0 loop
				addr_i <= conv_std_logic_vector(i,log2(LOCATIONS));	
								
				we_i <= '1';
				wait for clk_period*1025;
				
				end loop;

				we_i <= '0';
				
				wait for clk_period*6;
--call data from memory
for i in 0 to 0 loop
				
				
				we_i <= '0';
				addr_i <= (others => '0');
				burst_i <= "0111";
				
				req_i <= '1';
				wait for clk_period*7;
				req_i <= '0';
				wait for clk_period*2;	
				--assert ()
				--	report ""
				--	severity failure	
				end loop;
				wait for clk_period*10;
		
	assert (false)
		report "sim end"
		severity failure;
	end process;
end exercise;	
		

