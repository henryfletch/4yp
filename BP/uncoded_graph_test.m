x = -3:4;
x = 10.^(x./10);
y = 0.5*erfc(sqrt(x));

x = 10*log10(x); 

semilogy(x,y,'square')