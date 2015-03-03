function y = rtnRet(x,mu,sigma,lambda)

y = (1/(2*lambda*sigma*sqrt(2*pi)))*exp(-((x-mu).^2)./(2*sigma^2)).*...
    ((sigma^2./((sigma^2/lambda) + mu - x)) - (sigma^2./(-(sigma^2/lambda) + mu - x)));

end