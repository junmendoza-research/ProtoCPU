----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:28 01/04/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( clock : in STD_LOGIC;
           alu_sel : in STD_LOGIC_VECTOR(15 downto 0);
           op1 : in STD_LOGIC_VECTOR(31 downto 0);
           op2 : in STD_LOGIC_VECTOR(31 downto 0);
           result : out STD_LOGIC_VECTOR(31 downto 0));
end ALU;

architecture Behavioral of ALU is

component adder32 is
    Port( clock : in STD_LOGIC;
			 vA : in STD_LOGIC_VECTOR (31 downto 0);
			 vB : in STD_LOGIC_VECTOR (31 downto 0);
          vS : out STD_LOGIC_VECTOR (31 downto 0)
			);
			  
end component adder32;

begin

--	select_op : if alu_op = alu_add generate
--		exec_add : adder32 port map(clock, op1, op2, result);
--	end generate select_op; 
	
	ProcALU : process(alu_sel) 
	begin 
		SelectOp : if alu_sel = alu_add then    
--			result <= op1 + op2;
		elsif  alu_sel = alu_sub then
		
		else
		
		end if SelectOp;
	end process ProcALU;
	
end Behavioral;

