`timescale 1ns/1ps
module checkZero(in, zero);
input logic [63:0] in;
output logic zero;

logic one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen,fourteen,fivteen,sixteen;
logic one2,two2,three2,four2;

nor #50 nor1(one, in[0], in[1], in[2], in[3]);
nor #50 nor2(two, in[4], in[5], in[6], in[7]);
nor #50 nor3(three, in[8], in[9], in[10], in[11]);
nor #50 nor4(four, in[12], in[13], in[14], in[15]);
nor #50 nor5(five, in[16], in[17], in[18], in[19]);
nor #50 nor6(six, in[20], in[21], in[22], in[23]);
nor #50 nor7(seven, in[24], in[25], in[26], in[27]);
nor #50 nor8(eight, in[28], in[29], in[30], in[31]);
nor #50 nor9(nine, in[32], in[33], in[34], in[35]);
nor #50 nor10(ten, in[36], in[37], in[38], in[39]);
nor #50 nor11(eleven, in[40], in[41], in[42], in[43]);
nor #50 nor12(twelve, in[44], in[45], in[46], in[47]);
nor #50 nor13(thirteen, in[48], in[49], in[50], in[51]);
nor #50 nor14(fourteen, in[52], in[53], in[54], in[55]);
nor #50 nor15(fivteen, in[56], in[57], in[58], in[59]);
nor #50 nor16(sixteen, in[60], in[ 61], in[62], in[63]);

and #50 AND1(one2, one, two, three, four);
and #50 AND2(two2, five, six, seven, eight);
and #50 AND3(three2, nine, ten, eleven, twelve);
and #50 AND4(four2, thirteen, fourteen, fivteen, sixteen);

and #50 Final(zero, one2, two2, three2, four2);


endmodule 