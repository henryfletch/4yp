function L = llr_full(y,mu_e,sigma_e,SystemParams)

t = SystemParams.tYrs*365*24*3600;

% Erased state (fixed gaussian)
top = exp(-1.*((y-mu_e).^2)./(2.*sigma_e.^2));

% Programmed state (Varies; depends on N)
[mu_p,sigma_p] = getRetentionParams(SystemParams.N,t,...
    SystemParams.Vp,SystemParams.Verased);
% Uniform distribution:
a = SystemParams.Vp;
b = SystemParams.Vp + SystemParams.deltaVp;

bottom = (normcdf((y-a),mu_p,sigma_p) - normcdf((y-b),mu_p,sigma_p))./(b-a);

L = log(top./bottom);

end