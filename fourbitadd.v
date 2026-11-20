`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 09:15:59 AM
// Design Name: 
// Module Name: fourbitadd
// Project Name: 
// Target Devices: 
module fourbitadd(
input [3:0]A,
input [3:0]B,
input Cin,
output [4:0]S);


wire c1,c2,c3;

onebitadd nest0 (A[0], B[0], Cin, S[0], c1);
onebitadd nest1 (A[1], B[1], c1, S[1], c2);
onebitadd nest2 (A[2], B[2], c2, S[2], c3);
onebitadd nest3 (A[3], B[3], c3, S[3], S[4]);

endmodule      
    

module onebitadd (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule


module fourbitadd_reg (
    input            clk,
    input            rst_n,
    input      [3:0] A,
    input      [3:0] B,
    input            Cin,
    output reg [4:0] S
);
    wire [4:0] sum_comb;

    fourbitadd u_add (
        .A   (A),
        .B   (B),
        .Cin (Cin),
        .S   (sum_comb)
    );

    always @(posedge clk) begin
        if (!rst_n)
            S <= 5'b0;
        else
            S <= sum_comb;
    end
endmodule
