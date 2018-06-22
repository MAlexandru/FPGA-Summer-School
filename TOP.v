module TOP (input CLK, RST,// rb, gb, bb,
				input MODE,// culoare,
				//output [11:0] XPOS, YPOS,
				output [3:0] Rv, Gv, Bv,
				output HSync, VSync, DISP_ACTIVE, VSyncn, HSyncn);

reg [11:0] VizH, FrH, BH, SyH, VizV, FrV, BV, SyV;
reg [1:0] VAL;
wire s;
//wire [11:0] CNT;
wire HActive, VActive;

assign HSyncn=~HSync;
assign VSyncn=~VSync;

assign DISP_ACTIVE=(HActive&VActive);

assign Rv=(DISP_ACTIVE)?4'b1111:4'bZ;

assign Gv=4'b0;
assign Bv=4'b0;

HVSync dut1 (.FrontN(FrH),
				 .BackN(BH),
				 .SyncN(SyH),
				 .VizibilN(VizH),
				 .CLK(CLK),
				 .RST(RST),
				 .SyncO(HSync),
				 .s(s),
				 .DISP_ACTIVEs(HActive));			
				 
				 
HVSync dut2 (.FrontN(FrV),
				 .BackN(BV),
				 .RST(RST),
				 .SyncN(SyV),
				 .VizibilN(VizV),
				 .CLK(s),
				 .SyncO(VSync),
				 .DISP_ACTIVEs(VActive),
				 .s(w1));
				 
				 
/*Div_Frecv dut3 (.CLK(CLK),
					 .RST(RST),
					 .VAL(VAL),
					 .OUT(OUT));
	*/			 
/*Culori dut4 (.CLK(CLK),
				 .culoare(culoare),
				 .Rv(Rv),
				 .Gv(Gv),
				 .Bv(Bv),
				 .rb(rb),
				 .gb(gb),
				 .bb(bb));		
*/				 
always@(posedge CLK)			
case(MODE)
0: 
begin
	VizH<=800;
	FrH<=56;
	SyH<=120;
	BH<=64;
	VAL<=1;
	VizV<=600;
	FrV<=37;
	SyV<=6;
	BV<=23;
end
1:
begin 
	VizH<=640;
	FrH<=16;
	SyH<=96;
	BH<=48;
	VAL<=2;
	VizV<=480;
	FrV<=10;
	SyV<=2;
	BV<=33;
end
endcase
endmodule
