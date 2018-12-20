library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cnt1_wrap is
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

 end cnt1_wrap;
 
 architecture rtl of cnt1_wrap is
 signal cnt_in_ir : std_logic_vector(31 downto 0);
 signal res_ir, cnt_out_ir : std_logic_vector(5 downto 0);
 signal busy_i, en0_i, en1_i, go_i, go_ir0, go_ir1, go_ir2, go_ir3 : std_logic;
 signal a_ir : std_logic_vector(31 downto 0);
 signal ones_i : std_logic_vector(5 downto 0);
 -- Registers
 -- cnt1_ir : 0
 -- go_ir : 4
 -- busy : 8
 -- res_ir : 0xc


 begin
 -- Instantiate registers
 	REG_PROC : process(clk , reset)
 	begin
 		if reset = '1' then
 -- go_irx
		go_ir0 <= '0';
 		go_ir1 <= '0';
 		go_ir2 <= '0';
 		go_ir3 <= '0';
 -- cnt regs
 		cnt_in_ir <= (others=> '0');
 		res_ir <= (others=>'0');

 			elsif rising_edge(clk) then
 -- R0
				if en0_i = '1' then
				cnt_in_ir <= wrdata;
 			end if;
 -- go_irx
 --if en1_i = '1' then
		go_ir0 <= go_i;
 --end if;
 		go_ir1 <= go_ir0;
 		go_ir2 <= go_ir1;
 		go_ir3 <= go_ir2;
 --- res_ir
 			if go_ir3 = '1' then
 				res_ir <= cnt_out_ir;
 			end if;
 		end if;
 end process;
 -- Instantiate cnt1
 cnt1_reg_proc : process(clk , reset)
 begin
 	if reset = '1' then
		 a_ir <= (others=> '0');
		 cnt_out_ir <= (others => '0');
	elsif rising_edge(clk) then
		 a_ir <= cnt_in_ir;
		cnt_out_ir <= ones_i;
 	end if;
 end process;
 cnt_proc : process(a_ir)
 variable onesv : integer;
 begin
 onesv := 0;
 for i in 0 to 31 loop
 if a_ir(i)='1' then
 onesv := onesv + 1;
 end if;
 end loop;
 -- drive signal
 ones_i <= conv_std_logic_vector(onesv,6);
 end process;
 -- goProc
 goProc : process (en1_i, go_ir0)
 begin
 go_i <= '0';
 if en1_i = '1' and go_ir0 = '0' then
 go_i <= '1';
 end if;
 end process;
 -- enProc
 enProc : process(wr, addr, wrdata)
 begin
 -- Init values
 en0_i <= '0';
 en1_i <= '0';
 if wr = '1' then
 if conv_integer(addr) = 0 then en0_i <= '1'; end if;
 if conv_integer(addr) = 4 then en1_i <= '1'; end if;
 end if;
 end process;
 -- Produce busy_i
 busy_i <= go_i or go_ir0 or go_ir1 or go_ir2 or go_ir3;

 rdDataProc : process (cnt_in_ir, res_ir, addr, rd,busy_i)
 begin
 rddata <= (others=>'0');
 if rd = '1' then
 case conv_integer(addr) is
 when 0 => rddata <= cnt_in_ir;
 when 16#c# =>
 rddata(31 downto 6) <= (others=>'0');
rddata(5 downto 0) <= res_ir;
 when 8 => rddata(0) <= busy_i;
 when others =>rddata <= conv_std_logic_vector(16#12345678#,32);
 end case;
 end if;
 end process;
 end rtl;
