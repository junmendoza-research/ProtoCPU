----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:30:09 01/02/2014 
-- Design Name: 
-- Module Name:    Execute - Behavioral 
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

use cpu_types.ALL;

entity Execute is
	Port( clock : in  STD_LOGIC;
			instruction : in STD_LOGIC_VECTOR(31 downto 0); 
			command : in STD_LOGIC_VECTOR(31 downto 0); 
			endprogram : out STD_LOGIC;
			nextpc : out STD_LOGIC;
			memregion_register : inout t_MemRegister_15_32
		 );
end Execute;

architecture Behavioral of Execute is

	component ALU is
		 Port( clock : in STD_LOGIC;
				 alu_op : in STD_LOGIC_VECTOR(15 downto 0);
				 op1 : in STD_LOGIC_VECTOR(31 downto 0);
				 op2 : in STD_LOGIC_VECTOR(31 downto 0);
				 result : out STD_LOGIC_VECTOR(31 downto 0));
	end component ALU;
	
begin
	
end Behavioral;

