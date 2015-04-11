x = 0:0.01:6;
x = 10.^(x./10);
y = 0.5*erfc(sqrt(x));

x = 10*log10(x); 

semilogy(x,y)