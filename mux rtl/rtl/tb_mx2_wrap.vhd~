library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_mx2_wrap is

end tb_mx2_wrap;

architecture exercise of tb_mx2_wrap is
  
  component mx2_wrap

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

  signal clk_i :  std_logic;
  signal reset_i : std_logic;
  signal addr_i : std_logic_vector(7 downto 0);
  signal wrdata_i : std_logic_vector(31 downto 0);
  signal rd_i : std_logic;
  signal wr_i : std_logic;
  signal rddata_i : std_logic_vector(31 downto 0);

  constant CLK_PERIOD : time := 20 ns;
  constant DLY : time := CLK_PERIOD/4;


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

      DUT :mx2_wrap
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
        begin
          wait on reset_i until reset_i = '0';
          addr_i <= conv_std_logic_vector(0,8);
          wrdata_i <= conv_std_logic_vector(0,32);
          rd_i <= '0';
          wr_i <= '0';

          -- wait for a clock and then start writing to registers
          -- This is part of the whole verification campaign which checks the mux.

          --**********************************************************
          -- Check port A
          wait for CLK_PERIOD;
          -- Write R0 (opr1)
          addr_i <= conv_std_logic_vector(0 , 8);
          wrdata_i <= conv_std_logic_vector(16#dead# , 32);
          wr_i <= '1';
          wait for CLK_PERIOD;
          -- Check R0
          wr_i <= '0';
          rd_i <= '1';
          wait for CLK_PERIOD;
          assert (conv_integer(rddata_i) = 16#dead#) report "mx2:opr1_ir read  error" severity failure;
          -- All OK - prepare for wr
          wr_i <= '1';
          --**********************************************************
          -- Write R1 (opr2)
          addr_i <= conv_std_logic_vector(4 , 8);
          wrdata_i <= conv_std_logic_vector(16#beef# , 32);
          wr_i <= '1';
          wait for CLK_PERIOD;
          -- Check R1
          wr_i <= '0';
          rd_i <= '1';
          wait for CLK_PERIOD;
          assert (conv_integer(rddata_i) = 16#beef#) report "mx2:opr2_ir read  error" severity failure;
          -- All OK - prepare for wr
          wr_i <= '1';
          --**********************************************************
          -- Write R2 (sel_ir)
          addr_i <= conv_std_logic_vector(8 , 8);
          wrdata_i <= conv_std_logic_vector(0 , 32);
          wr_i <= '1';
          wait for CLK_PERIOD;
          -- Check R2
          wr_i <= '0';
          rd_i <= '1';
          wait for CLK_PERIOD;
          assert (conv_integer(rddata_i) = 0) report "mx2:sel_ir read  error" severity failure;

          --**********************************************************
          -- Write R4 (go_ir)
          rd_i <= '0';
          addr_i <= conv_std_logic_vector(16#c# , 8);
          wrdata_i <= conv_std_logic_vector(1 , 32);
          wr_i <= '1';
          wait for CLK_PERIOD;
          --**********************************************************
          -- Busy wait
          BUSY_WAIT_A : loop
            wr_i <= '0';
            rd_i <= '1';
            addr_i <= conv_std_logic_vector(16#14# , 8);
            wait for CLK_PERIOD;
            exit BUSY_WAIT_A when rddata_i(0) = '1';
          end loop;

          -- Drive res_ir address
          addr_i <= conv_std_logic_vector(16#10# , 8);
          wait for CLK_PERIOD;
          rd_i <= '0';
          assert (conv_integer(rddata_i) = 16#dead#) report "mx2: port a error" severity failure;

        --**********************************************************
        -- Check port B
          wr_i <= '1';
          --**********************************************************
          -- Write R2 (sel_ir)
          addr_i <= conv_std_logic_vector(8 , 8);
          wrdata_i <= conv_std_logic_vector(1 , 32);
          wr_i <= '1';
          wait for CLK_PERIOD;
          -- Check R2
          wr_i <= '0';
          rd_i <= '1';
          wait for CLK_PERIOD;
          assert (conv_integer(rddata_i) = 1) report "mx2:sel_ir read  error" severity failure;

          --**********************************************************
          -- Write R4 (go_ir)
          rd_i <= '0';
          addr_i <= conv_std_logic_vector(16#c# , 8);
          wrdata_i <= conv_std_logic_vector(1 , 32);
          wr_i <= '1';
          wait for CLK_PERIOD;
          --**********************************************************
          -- Busy wait
          BUSY_WAIT_B : loop
            wr_i <= '0';
            rd_i <= '1';
            addr_i <= conv_std_logic_vector(16#14# , 8);
            wait for CLK_PERIOD;
            exit BUSY_WAIT_B when rddata_i(0) = '1';
          end loop;

          -- Drive res_ir address
          addr_i <= conv_std_logic_vector(16#10# , 8);
          wait for CLK_PERIOD;
          rd_i <= '0';
          assert (conv_integer(rddata_i) = 16#beef#) report "mx2: port b error" severity failure;


          
          -- Using the above code, complete the testbench as instructed in the
          -- class
        end process;
  end exercise;
