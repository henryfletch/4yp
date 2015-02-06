function y = gen_gaussian(mu,sigma,samples)

%y = random('Normal',mu,sigma,samples,1);

y = sigma.*randn(1,samples) + mu;
end