function L = llr(y,mu_e,sigma_e,mu_p,sigma_p)

top = exp(-1.*((y-mu_e).^2)./(2.*sigma_e.^2));
bottom = exp(-1.*((y-mu_p).^2)./(2.*sigma_p.^2));

L = log(top./bottom);

end