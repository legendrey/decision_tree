`include "./juece_head.v"
module decision_tree(input       clock,start_i,reset,
	                 input [`DataWidth ] x1_i,
	                 input [`DataWidth ] x2_i,
	                 input [`DataWidth ] x3_i,
	                 output reg [`DataWidth ] y_o,
	                 output   reg     y_valid_o) ;
//wire [`ResultWidth] result;
reg  [`DataWidth ] Y4,Y3,Y2,Y1,A,B,C;
reg  [`RamWidth] decision_tree_table [`RamDepth];
initial
    begin
        $readmemb("decision_tree_table.txt",decision_tree_table,0,`RAM_MAX);
    end
reg  [`StateWidth]state;

//assign result[2] = (x1_i>A)? 1: 0;
//assign result[1] = (x2_i>B)? 1: 0;
//assign result[0] = (x3_i>C)? 1: 0;
always @ (*)
begin
 A = decision_tree_table[3'd0][21:14];
 B = decision_tree_table[3'd1][21:14];
 C = decision_tree_table[3'd2][21:14];
 Y3 = decision_tree_table[3'd2][7:0];
 Y4 = decision_tree_table[3'd4][7:0];
 Y1 = decision_tree_table[3'd5][7:0];
 Y2 = decision_tree_table[3'd6][7:0];
end 

 /*产生异步复位同步释放的信号resetn*/
reg a1,resetn;
always @(`CLK_EDGE clock or `RESET_EDGE reset) 
begin
	if(!reset)
	begin
		a1 <= 'd0;
		resetn <= 'd0;
	end
	else begin
		a1 <= 1;
		resetn <= a1;
	end
end 
/*异步复位同步释放的方式*/
always @(`CLK_EDGE clock or `RESET_EDGE resetn)
 begin
	if (!resetn)
 	begin
   		y_o <= `DATA_INIT;
   		y_valid_o <= `DISABLE;
   		state <= `STATE_0;
    end
	else if(start_i)
	begin
 		case (state)
 		`STATE_0:
		begin
			if(x1_i > A)
			begin
		  		state <= `STATE_1;
			end 
			else begin
		 		state <= `STATE_2; 
			end
		end
		`STATE_1:
		begin
	  		if(x2_i > B)
	  		begin
	    		state <= `STATE_3;
	  		end
	  		else begin
	  			state <= `STATE_4;
	  		end
		end
		`STATE_2:
		begin
	 		y_o <= Y3;
		end
		`STATE_3:
		begin
			if(x3_i > C)
	  		begin
	    		state <= `STATE_5;
	  		end
	  		else begin
	  			state <= `STATE_6;
	  		end
		end
		`STATE_4:
		begin
			y_o <= Y4;
		end
		`STATE_5:
		begin
			y_o <= Y1;
		end
		`STATE_6:
		begin
			y_o <= Y2;
		end
		endcase
	end
end
endmodule
	