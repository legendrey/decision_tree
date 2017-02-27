`define RESET_EDGE negedge //定义复位信号的有效边缘
`define CLK_EDGE posedge   //定义时钟沿的有效
`define DataWidth 7:0  //定义输入的Xi信号比特位
`define RamWidth 22:0 //定义RAM的数据宽度
`define RamDepth 7:0  //定义RAM的时钟深度
`define RAM_MAX 6  //定义RAM的最大深度
`define ResultWidth 2:0 //定义result的比特位
`define StateWidth 2:0 //定义state的比特位
`define STATE_0 3'd0 //定义状态的初始化值即空闲状态
`define STATE_1 3'd1 //定义1状态
`define STATE_2 3'd2  //定义2的状态
`define STATE_3 3'd3 //定义3状态
`define STATE_4 3'd4  //定义4的状态
`define STATE_5 3'd5 //定义5状态
`define STATE_6 3'd6  //定义6的状态
`define DATA_INIT 8'd0 //初始化数据的值
`define  DISABLE 1'b0 