function logEb = mackay_test(x)
r = 0.5;
sigma = 1;
ebno = x .* x ./ ( 2 .* r .* sigma .* sigma ) ; 
logEb = 10.0 .* log10(ebno);

end
