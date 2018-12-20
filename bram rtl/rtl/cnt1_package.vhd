library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

package cnt1_package is
	constant W : integer := 1024;
	function log2 ( a : in integer ) return integer;
end;

package body cnt1_package is 
--begin
	function log2 ( a : in integer ) return integer is 
	variable res : integer := 0;
	begin 
		if ( a = 0 ) then
			assert (false) report "log2 called with 0 arg" 
				severity error;
		elsif ( a < 0 ) then
			assert (false) report "log2 called with -ve arg" 
				severity error;
		elsif ( a = 1 or a = 2) then
			res := 1;
		elsif ( a = 3 or a = 4 ) then
			res := 2;
		elsif ( a > 4 and a <= 8 ) then
			res := 3;
		elsif ( a > 8 and a <= 16 ) then
			res := 4;
		elsif ( a > 16 and a <= 32 ) then
			res := 5;
		elsif ( a > 32 and a <= 64 ) then
			res := 6;
		elsif ( a > 64 and a <= 128 ) then
			res := 7;
		elsif ( a > 128 and a <= 256 ) then
			res := 8;
		elsif ( a > 256 and a <= 512 ) then
			res := 9;
		elsif ( a > 512 and a <= 1024 ) then
			res := 10;
		elsif ( a > 1024 and a <= 2048 ) then
			res := 11;
		elsif ( a > 2048 and a <= 4096 ) then
			res := 12;
		elsif ( a > 4096 and a <= 8192 ) then
			res := 13;
		elsif ( a > 8196 and a <= 16384 ) then
			res := 14;
		elsif ( a > 16384 and a <= 32768 ) then
			res := 15;
		elsif ( a > 32768 and a <= 65536 ) then
			res := 16;
		end if;
	return (res);
	end;
end;		
