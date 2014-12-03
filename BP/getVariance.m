% Gaussian Noise Function
% Inputs: EbNo, Energy/info bit; Rc, code rate; Rm, modulation rate;
% Outputs: (Sigma)^2, Noise Variance

function variance = getVariance(EbNo,Rc,Rm)

linEbNo = 10^(EbNo/10); % dB -> Ratio
variance = 1/(2*Rm*Rc*linEbNo);

end
