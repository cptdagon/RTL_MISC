library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mx2_wrap is

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
    
  end mx2_wrap;

  architecture rtl of mx2_wrap is

    signal opr1_ir, opr2_ir, z_i, res_ir : std_logic_vector(31 downto 0);
    signal en0_i, en1_i, en2_i, en3_i,  go_ir,sel_ir, rdy_ir  : std_logic;
    
    	component mux2_multibit
    	generic (width : integer := 32);
	port (
		A : in std_logic_vector(width -1 downto 0);
		B : in std_logic_vector(width -1 downto 0);
		sel : in std_logic;
		Z : out std_logic_vector(width -1 downto 0)
);
	 end component;
    
    begin
      -- Instantiate a 32-bit register with enable here (I_R0)
      I_R0_PROC : process(clk , reset)
        begin
          if reset = '1' then
            opr1_ir <= (others=>'0');
          elsif rising_edge(clk) then
            if en0_i = '1' then
              opr1_ir <= wrdata;
            end if;
          end if;
        end process;

      -- Instantiate a 32-bit register with enable here (I_R1)
      I_R1_PROC : process(clk , reset)
        begin
          if reset = '1' then
            opr2_ir <= (others=>'0');
          elsif rising_edge(clk) then
            if en1_i = '1' then
              opr2_ir <= wrdata;
            end if;
          end if;
        end process;

      -- Instantiate a 1-bit register with enable here (I_R2)
      I_R2_PROC : process(clk , reset)
        begin
          if reset = '1' then
            sel_ir <= '0';
          elsif rising_edge(clk) then
            if en2_i = '1' then
              sel_ir <= wrdata(0);
            end if;
          end if;
        end process;
        
      -- Instantiate a 1-bit register with enable here (I_R3)
      I_R3_PROC : process(clk , reset)
        begin
          if reset = '1' then
            go_ir <= '0';
          elsif rising_edge(clk) then
            if en3_i = '1' and go_ir = '0' then
              go_ir <= '1';
            else
              go_ir <= '0';
            end if;
          end if;
        end process;

      -- Instantiate a 32-bit register with enable here (I_R4)
      I_R4_PROC : process(clk , reset)
        begin
          if reset = '1' then
            res_ir <= (others=>'0');
          elsif rising_edge(clk) then
            if go_ir = '1' then
              res_ir <= z_i;
            end if;
          end if;
        end process;

      -- Instantiate a 1-bit register  (I_R5)
      I_R5_PROC : process(clk , reset)
        begin
          if reset = '1' then
            rdy_ir <= '0';
          elsif rising_edge(clk) then
            if go_ir = '1' then
              rdy_ir <= '1';
            elsif rd = '1' then
              rdy_ir <= '0';
            end if;
          end if;
        end process;
        
        -- Instantiate mx2
 	MX2 : mux2_multibit
		port map (
		A	=>	opr1_ir,
		B	=>	opr2_ir,
		sel	=>	sel_ir,
		Z	=>	Z_i );
	
		
      -- enProc
      enProc : process(wr, addr, wrdata)
        begin
          -- Init values
          en0_i <= '0';
          en1_i <= '0';
          en2_i <= '0';
          en3_i <= '0';

          if wr = '1' then
            if conv_integer(addr) = 0 then en0_i <= '1'; end if;
            if conv_integer(addr) = 4 then en1_i <= '1'; end if;
            if conv_integer(addr) = 8 then en2_i <= '1'; end if;
            if conv_integer(addr) = 16#c# then en3_i <= '1'; end if;
          end if;
        end process;
      rdDataProc : process (opr1_ir, opr2_ir, sel_ir, rdy_ir, addr, rd)
        begin
          rddata <= (others=>'0');
          case conv_integer(addr) is
            when 0 => rddata <= opr1_ir;
            when 4 => rddata <= opr2_ir;
            when 8 => rddata(0) <= sel_ir;
            when 16#10# => rddata <= res_ir;
            when 16#14# => rddata(0) <= rdy_ir;
            when others =>rddata <= conv_std_logic_vector(16#12345678#,32);
          end case;
        end process;
    end rtl;
