Library ieee;
Use ieee.std_logic_1164.all;
Entity inv is 
Port (
A : in std_logic;
Z : out std_logic
);
end inv;

	architecture dataflow of inv is
	begin
	Z <= not A;
	end dataflow;
