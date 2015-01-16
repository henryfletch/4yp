%This is a gaussian; the voltage ditribution of the erased (0,0) state
function y = mem_erasedState(x,mu,sigma)

a = 1/(sigma*sqrt(2*pi));
b = ((x - mu).^2)./(2*sigma^2);

y = a*exp(-b);

end