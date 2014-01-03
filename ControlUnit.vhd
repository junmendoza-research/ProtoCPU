----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:06:01 11/17/2013 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code. 
--library UNISIM;
--use UNISIM.VComponents.all;

use cpu_types.ALL;

entity ControlUnit is
    Port ( 
		clock : in STD_LOGIC;
		reset : in STD_LOGIC;
		result : out STD_LOGIC
			);
			
end ControlUnit;


-------------------------------------
-- component ControlUnit()
--		MemoryInit()
--		LoadInstructions()
--		SetFirstPC()
--		Fetch(in pc, out instr)
--		Decode(in instr, out pc)
--		GetNextPC(out pc)
-- end component
-------------------------------------
	
architecture Behavioral of ControlUnit is

	------------------------------------
	-- Component definitions 
	------------------------------------
	component Fetch is 
		Port( clock : in STD_LOGIC; 
				pc : in STD_LOGIC_VECTOR(31 downto 0);
				instr : out STD_LOGIC_VECTOR(31 downto 0)
			 );
	end component Fetch;
	
	component Decode is  
		Port( clock : in STD_LOGIC;
				instruction : in STD_LOGIC_VECTOR(31 downto 0); 
				
				exec_add  : out STD_LOGIC;
				exec_sub  : out STD_LOGIC;
				exec_mul  : out STD_LOGIC;
				exec_div  : out STD_LOGIC;
				exec_and  : out STD_LOGIC;
				exec_nand : out STD_LOGIC;
				exec_or   : out STD_LOGIC;
				exec_nor  : out STD_LOGIC;
				exec_xor  : out STD_LOGIC;
				exec_xnor : out STD_LOGIC;
				exec_not  : out STD_LOGIC;
				exec_shl  : out STD_LOGIC;
				exec_shr  : out STD_LOGIC;
				
				exec_mov  : out STD_LOGIC;
				exec_ldr  : out STD_LOGIC;
				exec_str  : out STD_LOGIC;
				exec_push : out STD_LOGIC;
				exec_pop  : out STD_LOGIC;
				
				exec_jmp  : out STD_LOGIC;
				
				exec_int  : out STD_LOGIC
			 );
	end component Decode;
	
	component Execute is  
		Port( clock : in  STD_LOGIC;
				instruction : in STD_LOGIC_VECTOR(31 downto 0); 
				
				exec_add  : in STD_LOGIC;
				exec_sub  : in STD_LOGIC;
				exec_mul  : in STD_LOGIC;
				exec_div  : in STD_LOGIC;
				exec_and  : in STD_LOGIC;
				exec_nand : in STD_LOGIC;
				exec_or   : in STD_LOGIC;
				exec_nor  : in STD_LOGIC;
				exec_xor  : in STD_LOGIC;
				exec_xnor : in STD_LOGIC;
				exec_not  : in STD_LOGIC;
				exec_shl  : in STD_LOGIC;
				exec_shr  : in STD_LOGIC;
				
				exec_mov  : in STD_LOGIC;
				exec_ldr  : in STD_LOGIC;
				exec_str  : in STD_LOGIC;
				exec_push : in STD_LOGIC;
				exec_pop  : in STD_LOGIC;
				
				exec_jmp : in STD_LOGIC;
				
				exec_int : in STD_LOGIC;
				
				endprogram : out STD_LOGIC;
				memregion_register : inout t_MemRegister_15_32
		    );
	end component Execute;
	
	component GetNextPC is 
		Port( clock : in STD_LOGIC;
			   pc : out STD_LOGIC_VECTOR(31 downto 0)
			 );
	end component GetNextPC;
	
	
	------------------------------------
	-- ControlUnit signals
	------------------------------------
	
	signal pc_instr_address : integer;
	signal endexecution : STD_LOGIC;
	
	-- Registers
	signal R1  : STD_LOGIC_VECTOR(31 downto 0);
	signal R2  : STD_LOGIC_VECTOR(31 downto 0);
	signal R3  : STD_LOGIC_VECTOR(31 downto 0);
	signal R4  : STD_LOGIC_VECTOR(31 downto 0);
	signal R5  : STD_LOGIC_VECTOR(31 downto 0);
	signal R6  : STD_LOGIC_VECTOR(31 downto 0);
	signal R7  : STD_LOGIC_VECTOR(31 downto 0);
	signal R8  : STD_LOGIC_VECTOR(31 downto 0);
	signal R9  : STD_LOGIC_VECTOR(31 downto 0);
	signal R10 : STD_LOGIC_VECTOR(31 downto 0);
	signal R11 : STD_LOGIC_VECTOR(31 downto 0);
	signal R12 : STD_LOGIC_VECTOR(31 downto 0);
	signal R13 : STD_LOGIC_VECTOR(31 downto 0);
	signal R14 : STD_LOGIC_VECTOR(31 downto 0);
	signal R15 : STD_LOGIC_VECTOR(31 downto 0);
	
	-- Command signals
	signal execute_add  : STD_LOGIC;
	signal execute_sub  : STD_LOGIC;
	signal execute_mul  : STD_LOGIC;
	signal execute_div  : STD_LOGIC;
	signal execute_and  : STD_LOGIC;
	signal execute_nand : STD_LOGIC;
	signal execute_or   : STD_LOGIC;
	signal execute_nor  : STD_LOGIC;
	signal execute_xor  : STD_LOGIC;
	signal execute_xnor : STD_LOGIC;
	signal execute_not  : STD_LOGIC;
	signal execute_shl  : STD_LOGIC;
	signal execute_shr  : STD_LOGIC;
		
	signal execute_mov  : STD_LOGIC;
	signal execute_ldr  : STD_LOGIC;
	signal execute_str  : STD_LOGIC;
	signal execute_push : STD_LOGIC;
	signal execute_pop  : STD_LOGIC;
		
	signal execute_jmp  : STD_LOGIC;
		
	signal execute_int  : STD_LOGIC;
	
	------------------------------------
	-- Initialize program region (Instruction Stream)
	-- 32 * 16-bit
	------------------------------------
	type t_MemArray_32_32 is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	signal memregion_program : t_MemArray_32_32 := 
	(
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000",
		X"00000000", X"00000000", X"00000000", X"00000000"	
	);
	 
begin
	
	-- Set start PC	
	--R1 <= X"00000000";
	
	-- Fetch
	pc_instr_address <= to_integer(signed(R1));
	R2 <= memregion_program(pc_instr_address);
	

	DecodeInstruction : Decode port map 
	(
		clock,
		R2,
		execute_add,
		execute_sub,
		execute_mul, 
		execute_div, 
		execute_and, 
		execute_nand,
		execute_or,  
		execute_nor, 
		execute_xor,
		execute_xnor,
		execute_not, 
		execute_shl, 
      execute_shr, 
      
      execute_mov, 
      execute_ldr, 
      execute_str, 
      execute_push,
      execute_pop, 
      
      execute_jmp, 
      
      execute_int
	);
	
	ExecuteCommand: Execute port map
	(
		clock,
		R2,
		
		execute_add,
		execute_sub,
		execute_mul, 
		execute_div, 
		execute_and, 
		execute_nand,
		execute_or,  
		execute_nor, 
		execute_xor,
		execute_xnor,
		execute_not, 
		execute_shl, 
      execute_shr, 
      
      execute_mov, 
      execute_ldr, 
      execute_str, 
      execute_push,
      execute_pop, 
      
      execute_jmp, 
      
      execute_int,
		
		endexecution, 
		
		memregion_register(R1_addr) => R1, 
		memregion_register(R2_addr) => R2, 
		memregion_register(R3_addr) => R3, 
		memregion_register(R4_addr) => R4, 
		memregion_register(R5_addr) => R5, 
		memregion_register(R6_addr) => R6, 
		memregion_register(R7_addr) => R7, 
		memregion_register(R8_addr) => R8, 
		memregion_register(R9_addr) => R9, 
		memregion_register(R10_addr) => R10, 
		memregion_register(R11_addr) => R11, 
		memregion_register(R12_addr) => R12, 
		memregion_register(R13_addr) => R13, 
		memregion_register(R14_addr) => R14, 
		memregion_register(R15_addr) => R15
	);
	
	GetPC : GetNextPC port map(clock, R1);	
	
end architecture Behavioral;
