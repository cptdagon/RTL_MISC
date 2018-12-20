library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity tb_cnt1_wrap is
end tb_cnt1_wrap;
architecture exercise of tb_cnt1_wrap is

 component cnt1_wrap
 port
 (
 clk : in std_logic;
 reset : in std_logic;
 addr : in std_logic_vector(7 downto 0);
 wrdata : in std_logic_vector(31 downto 0);
 rd : in std_logic;
 wr : in std_logic;
 rddata : out std_logic_vector(31 downto 0)
 );

 end component;
 signal clk_i : std_logic;
 signal reset_i : std_logic;
 signal addr_i : std_logic_vector(7 downto 0);
 signal wrdata_i : std_logic_vector(31 downto 0);
 signal rd_i : std_logic;
 signal wr_i : std_logic;
 signal rddata_i : std_logic_vector(31 downto 0);
 constant CLK_PERIOD : time := 20 ns;
 constant DLY : time := CLK_PERIOD/4;
constant VECTORS : integer := 16#100000#;
 begin
 clkmeProc : process
 begin
 clk_i <= '1';
 wait for CLK_PERIOD/2;
 clk_i <= '0';
 wait for CLK_PERIOD/2;
 end process;
 resetmeProc : process
 begin
 wait for DLY;
 reset_i <= '1';
 wait for CLK_PERIOD;
 reset_i <= '0';
 wait;
 end process;
 DUT :cnt1_wrap
 port map
 (
 clk =>clk_i,
 reset => reset_i,
 addr => addr_i,
 wrdata => wrdata_i,
 rd => rd_i,
 wr => wr_i,
 rddata => rddata_i
 );
 stimProc : process
 variable goodonesv : integer;
 begin
 wait on reset_i until reset_i = '0';
 addr_i <= conv_std_logic_vector(0,8);
 wrdata_i <= conv_std_logic_vector(0,32);
 rd_i <= '0';
 wr_i <= '0';
 wait for CLK_PERIOD;
 -- wait for a clock and then start writing to registers
 -- This is part of the whole verification campaign which checks the mux.
 -- Iterate over 8 numbers
 for i in 0 to VECTORS-1 loop
 -- Write R0 (opr1)
 addr_i <= conv_std_logic_vector(0 , 8);
 wrdata_i <= conv_std_logic_vector(i , 32);
 wr_i <= '1';
 wait for CLK_PERIOD;
 -- Read back and confirm
 rd_i <= '1';
 wr_i <= '0';
 wait for CLK_PERIOD;
 rd_i <= '0';
 assert (conv_integer(rddata_i) = i) report "cnt1:cnt1_in_ir read error" severity
failure;
 -- Write go
 wait for CLK_PERIOD;
 wr_i <= '1';
 addr_i <= conv_std_logic_vector(4 , 8);
 wait for CLK_PERIOD;
 wr_i <= '0';
 --wait for 16 * CLK_PERIOD;
 -- Busy wait
 BUSY_WAIT_A : loop
 rd_i <= '1';
 addr_i <= conv_std_logic_vector(16#8# , 8);
 wait for CLK_PERIOD;
 exit BUSY_WAIT_A when rddata_i(0) = '0';
 end loop;

 rd_i <= '0';
 wait for CLK_PERIOD;
 -- extract result
 rd_i <= '1';
 addr_i <= conv_std_logic_vector(16#c# , 8);
 wait for CLK_PERIOD;
 -- Now, check !!
 goodonesv := 0;
 for j in 0 to 31 loop
 if conv_std_logic_vector(i,32)(j) = '1' then
 goodonesv := goodonesv + 1;
 end if;
 end loop;
 assert (goodonesv = rddata_i) report "Failure on cnt1_wrap" severity Failure;
 rd_i <= '0';
 wait for CLK_PERIOD;
 end loop;
 assert (false) report "SUCCESS - Ending with 'Failure' assertion" severity Failure;

 end process;
 end exercise;
