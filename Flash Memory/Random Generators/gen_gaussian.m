function y = gen_gaussian(mu,sigma,samples)

y = random('Normal',mu,sigma,samples,1);

end