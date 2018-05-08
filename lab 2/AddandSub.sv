module AddandSub (Cout, S, Sub, A, B, Cin);
output Cout, S; 
input A, B, Cin, Sub ;

wire AB;
wire ACin;
wire BCin;
wire Bnew;



xor xor1(Bnew, Sub, B);
and and1(AB,A,Bnew);
and and2(ACin,A,Cin);
and and3(BCin, Bnew, Cin);

or(Cout,AB,ACin,BCin);


xor sum(S, A, B, Cin);

endmodule




