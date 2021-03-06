library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.cnt1_package.all;

entity ram_piped is
generic (LOCATIONS : integer := 1024 ; WIDTH : integer := 32);
	port (
		clk : in std_logic;					--clk
		reset : in std_logic;				--reset
		wein : in std_logic; 				--we
		addrin : in std_logic_vector(log2(LOCATIONS)-1 downto 0); 	--addr
		p_din : in std_logic_vector(WIDTH-1 downto 0); 		--D
		p_dout : out std_logic_vector(WIDTH-1 downto 0) 		--Q
);
	
end ram_piped;

architecture struct of ram_piped is
	signal din : std_logic_vector(WIDTH-1 downto 0); 			-- 
	signal I_d2 : std_logic_vector(WIDTH-1 downto 0);			-- I_d2
	signal I_q1 : std_logic_vector(WIDTH -1 downto 0);		-- I_q1
	signal dout : std_logic_vector(WIDTH -1 downto 0);	
	signal addr_sig : std_logic_vector(log2(LOCATIONS)-1 downto 0);	-- addr_in
	signal we_sig : std_logic;					-- we_in
	signal I_Q : std_logic_vector(WIDTH -1 downto 0);			-- I_Q
	
	component param_reg
	generic (WIDTH : integer := 32);
	port(
		clk, reset : in std_logic;
		d : in std_logic_vector(Width -1 downto 0);
		q : out std_logic_vector(width -1 downto 0)
);
end component;

	component bram_param
	generic (LOCATIONS : integer := 1024 ; WIDTH : integer := 32);
	port(
		clk : in std_logic;
		addr : in std_logic_vector(log2(LOCATIONS)-1 downto 0);
		din : in std_logic_vector(WIDTH-1 downto 0);
		dout : out std_logic_vector(WIDTH-1 downto 0);
		we : in std_logic
);
end component;

	component dff
	port (
		clk : in std_logic;		
		reset : in std_logic;	
		d : in std_logic;	
		q : out std_logic
);
end component;

begin 
	I_reg1 : param_reg port map (
		clk => clk,	-- clk
		reset => reset,	-- reset
		d => p_din,	-- D
		q => I_q1
);
	I_reg2 : param_reg port map (
		clk => clk,	-- clk
		reset => reset,	-- reset
		d => I_d2,	-- I_d2
		q => I_Q		-- I_Q
);
	I_reg3 : param_reg generic map(
		WIDTH => log2(LOCATIONS)
)
	 port map (
		clk => clk, 	-- clk
		reset => reset,	-- reset
		d => addrin,	-- addr
		q => addr_sig	-- addr_in
);
	I_dff1 : dff port map (
		clk => clk,	-- clk
		reset => reset,	-- reset
		d => wein,	-- we
		q => we_sig	-- we_in
);	
	I_bram : bram_param port map(
		clk => clk,	-- clk
		addr => addr_sig,	-- addr_in
		din =>  I_q1,
		dout => I_d2,	-- I_d2
		we => we_sig	-- we_in
);
p_dout <= I_Q;
end struct;
		
		
		
		
		
