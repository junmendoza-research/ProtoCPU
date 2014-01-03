----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:05:34 12/09/2013 
-- Design Name: 
-- Module Name:    Fetch - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all; 

entity Fetch is
    Port	( clock : in STD_LOGIC; 
			  pc : in STD_LOGIC_VECTOR(31 downto 0);
			  instr : out STD_LOGIC_VECTOR(31 downto 0)
			);
end Fetch;

architecture Behavioral of Fetch is
	
begin

	FetchInstr : process(clock)
	begin
		ClockSync : if rising_edge(clock) then
			-- Retrieve the instruction from the instruction stream given the pc input
			-- Store the instruction in the instruction register
			-- instr = memregion_instrstrean[pc]
			instr <= "0000000000000001";
		end if ClockSync;
	end process FetchInstr;

end Behavioral;

