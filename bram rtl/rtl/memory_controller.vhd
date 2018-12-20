library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.cnt1_package.all;

entity memory_controller is
generic (LOCATIONS : integer := 1024 ; WIDTH : integer := 32);
	port(
		clk	:	in std_logic;
		reset	:	in std_logic;
		req	:	in std_logic;
		addr	:	in std_logic_vector(log2(LOCATIONS)-1 downto 0);
		burst	:	in std_logic_vector(3 downto 0);
		rdy	:	out std_logic;
		c_dout	:	out std_logic_vector(31 downto 0);
		
		we	: 	in std_logic
			
);

end memory_controller;

architecture struct of memory_controller is
	
	signal int_dout 	: 	std_logic_vector(WIDTH-1 downto 0);
	signal addrint 	: 	std_logic_vector(log2(LOCATIONS)-1 downto 0);
	signal mem_din	: 	std_logic_vector(32-1 downto 0);
	
	component ram_piped
	generic (LOCATIONS : integer := 1024 ; WIDTH : integer := 32);
	port (
		clk 	: 	in std_logic;					
		reset 	: 	in std_logic;				
		wein 	: 	in std_logic; 				
		addrin 	: 	in std_logic_vector(log2(LOCATIONS)-1 downto 0); 	
		p_din 	: 	in std_logic_vector(WIDTH-1 downto 0); 		
		p_dout 	:	out std_logic_vector(WIDTH-1 downto 0) 		
);
end component;

	component fsm
	port(
		clk	:	in std_logic;
		reset	:	in std_logic;
		req	:	in std_logic;
		addr	:	in std_logic_vector(log2(LOCATIONS)-1 downto 0);
		burst	:	in std_logic_vector(3 downto 0);
		din	:	in std_logic_vector(31 downto 0);
		maddr	:	buffer std_logic_vector(log2(LOCATIONS)-1 downto 0);
		dout	:	out std_logic_vector(31 downto 0);
		rdy	:	out std_logic;
		
		memdout	:	buffer std_logic_vector(31 downto 0);
		we	:	in std_logic
);
end component;



begin
	


	I_fsm : fsm port map (
		clk => clk,
		reset => reset,
		req => req,
		addr => addr,
		burst => burst,
		dout => c_dout,
		rdy => rdy,
		din => int_dout,
		maddr => addrint,
		we => we,
		memdout => mem_din
	);
	
	I_ram_piped : ram_piped 
	generic map(
		LOCATIONS => 1024,
		WIDTH => 32)
	port map (
		clk => clk,
		reset => reset,
		wein => we,
		addrin => addrint,
		p_din => mem_din,
		p_dout => int_dout
);
end struct;
		
		
