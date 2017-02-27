`include "./juece.v"
`timescale 1ns/1ns
module test;
  reg   clock,start_i,reset;
  reg [`DataWidth ] x1_i;
  reg [`DataWidth ] x2_i;
  reg [`DataWidth ] x3_i;
  wire  [`DataWidth ] y_o;
  wire      y_valid_o;

initial begin
$display(y_o,y_valid_o);
#1 $stop;
end

initial 
begin
	clock = 0;
    reset = 0;
	start_i = 'd1;
	x1_i = 'd1;
	x2_i = 'd4;
	x3_i = 'd7;
	repeat(30) begin 
		#2 clock = ~ clock;	
	end
end
initial
begin
	#1 reset = ~ reset;
end

initial
begin
	repeat(4)
	begin
		fork
			#20 x1_i <= {$random} % 256;
			#20	x2_i <= {$random} % 256;
			#20	x3_i <= {$random} % 256;
		join
	end
end
decision_tree	decision_tree(clock,start_i,reset,x1_i,x2_i,x3_i,y_o,y_valid_o);
initial
begin
	$dumpfile ("juece.vcd");
	$dumpvars(0,test);
end
endmodule