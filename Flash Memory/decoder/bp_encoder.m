function x_encoded = bp_encoder(x,H)

h = comm.LDPCEncoder(H);
x_encoded = step(h,x');

end