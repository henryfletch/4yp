function y = normexp(x,mu,sigma,lambda)

y = (lambda/2)*exp((lambda/2)*(2*mu+lambda*sigma^2-2*x)).*erfc((mu+lambda*sigma^2-x)/(sqrt(2)*sigma));

end