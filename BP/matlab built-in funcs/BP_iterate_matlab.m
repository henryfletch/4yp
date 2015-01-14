function y = BP_iterate_matlab(x,H,l)

decoder = comm.LDPCDecoder('ParityCheckMatrix',H,'OutputValue','Whole codeword','DecisionMethod','Soft decision','MaximumIterationCount',l);
y = step(decoder,x');

end

