%This is a double sided exponential; it is the RTN function
function y = mem_RTN(x,N)

lambda = 0.00025*N^0.5;
y = (1/(2*lambda))*exp(-abs(x)/lambda);

end