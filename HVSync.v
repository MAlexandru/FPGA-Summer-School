module HVSync (input [11:0] VizibilN, FrontN, SyncN, BackN,
					input CLK, RST,
					output SyncO, DISP_ACTIVEs,
					output reg s);
reg [11:0] CNT;
wire [11:0] S1, S2, S3;

					
assign S1=VizibilN + FrontN;
assign S2=VizibilN + FrontN + SyncN;
assign S3=VizibilN + BackN + SyncN + FrontN;
assign SyncO=((CNT<S1) | (CNT>=S2))?1:0;
assign DISP_ACTIVEs=(CNT<VizibilN)?1:0;

always@(posedge CLK)
if (~RST)
	CNT<=0;
else
	if (CNT==S3) begin
			CNT<=0;
			s <= 1;
		end
	else begin
			CNT<=CNT+1;
			s <= 0;
			
	end

//always@(posedge CLK)

//if (CNT==S3)
//	s<=1;
//else
//	s<=0;
endmodule
