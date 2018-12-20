library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.cnt1_package.all;
entity fsm is
generic (LOCATIONS : integer := 1024 ; WIDTH : integer := 32);
	port(
		clk	:	in std_logic;
		reset	:	in std_logic;
		req	:	in std_logic;
		addr	:	in std_logic_vector(log2(LOCATIONS)-1 downto 0);--31 downto 0);
		burst	:	in std_logic_vector(3 downto 0);
		din	:	in std_logic_vector(31 downto 0);
		maddr	:	buffer std_logic_vector(log2(LOCATIONS)-1 downto 0);--31 downto 0);
		dout	:	out std_logic_vector(31 downto 0);
		rdy	:	out std_logic;
		
		memdout	:	buffer std_logic_vector(31 downto 0);
		we	:	in std_logic
);
end fsm;

architecture rtl of fsm is
	constant clk_period : time := 10 ns;
	constant mem_delay : time := 30 ns;
	type state_type is (IDLE_st, REQ_st, PLCHDR_st, FILL_st);
	signal state_ir 	: 	state_type;
	signal cnt_ir 	: 	std_logic_vector(3 downto 0);
	signal memfill_ir 	: 	state_type;
	
begin
	moore_proc : process(clk, reset)
	begin
		if reset = '1' then 
			-- reset fsm
			state_ir <= IDLE_st;
			-- drive outputs
			maddr <= (others => '0');
			-- reset internal counter
			cnt_ir <= (others => '0');
			-- reset burst fill proc
			memfill_ir <= PLCHDR_st;
			-- drive outputs
			memdout <= (others => '0');
	
		elsif rising_edge(clk) then
			case state_ir is
			when IDLE_st =>
				if req = '1' then
					maddr <= addr; --registered maddr
					state_ir <= REQ_st;
					cnt_ir <= burst; -- save burst length
				end if;
				
			when req_st =>
				if (conv_integer(cnt_ir) /= 0) then
					-- increment address
					 maddr <= maddr + 1;
					-- decrement burst counter
					cnt_ir <= cnt_ir - 1;
					-- assert rdy strobe 
					rdy <= '1';
				else
					-- refill done. go back to idle
					state_ir <= IDLE_st;
					rdy <= '0';
				end if;
				
			when others =>
				-- error state
				-- the fsm must go back to the reset/IDLE state
				state_ir <= IDLE_st;
			end case;
			
			case memfill_ir is
			when PLCHDR_st =>
				if we = '1' then
					memdout <= conv_std_logic_vector(16#deadbeef#, 32);
					maddr <= addr;
					memfill_ir <= FILL_st;
				end if;
			when FILL_st =>
				if (maddr /= 1023) then
					maddr <= maddr + 1;
					memdout <= memdout + 1;
				else
					memfill_ir <= IDLE_st;
					
				end if;		
				
			when others =>
				-- error state
				-- the fsm must go back to the reset/IDLE state
				memfill_ir <= IDLE_st;
			end case;
		end if;
	end process;

	pipe_reg_proc : process(clk)
	begin
		if reset = '1' then
			dout <= (others => '0');
		elsif rising_edge(clk) then
			if (state_ir = REQ_st) then
				-- only pipe din when fsm in REQ_st
				-- dout to din occurs 3 cycles too early
				dout <= transport din; --after mem_delay;
			end if;
		end if;
	end process;
end rtl;

				
				
				
		
				
