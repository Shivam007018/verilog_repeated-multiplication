module CONTROLLER(done, lda, ldb, ldp, decb, clrp, start, clk, eqz); // eqz is used for state change from 3 to 4
    input start, clk, eqz;
    output reg done, lda, ldb, ldp, decb, clrp;
    reg [2:0] state;

    
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;

    initial state = s0;

    always @(posedge clk) begin
        case(state)
            s0: if (start) state <= s1;  
            s1: state <= s2;
            s2: state <= s3;
            s3: if (eqz) state <= s4;
            s4: state <= s4; 
            default: state <= s0;
        endcase
    end

   
    always @(state) begin
       
        lda = 0; ldb = 0; ldp = 0; decb = 0; clrp = 0; done = 0;

        case(state)
            s0 : begin lda = 0; ldb = 0; ldp = 0; decb = 0; clrp = 0; done = 0; end
            s1 : begin lda = 1; end
            s2 : begin lda = 0; ldb = 1; clrp = 1; end
            s3 : begin ldb = 1; clrp = 1; ldp = 1; decb = 1; end
            s4 : begin done = 1; lda = 0; ldb = 0; ldp = 0; decb = 0; clrp = 0; end
            default : begin lda = 0; ldb = 0; ldp = 0; decb = 0; clrp = 0; done = 0; end
        endcase
    end
endmodule
