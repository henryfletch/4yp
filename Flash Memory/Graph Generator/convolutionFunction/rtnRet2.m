function y = rtnRet2(t,mu,sigma,lambda)

y = (1/2*lambda)*exp(sigma^2/2*lambda^2)*exp(-t./lambda).*(1-erf(-(t-mu-(sigma^2*lambda))./sigma*sqrt(2)));
end
