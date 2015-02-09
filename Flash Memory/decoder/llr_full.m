function L = llr_full(y,mu_e,sigma_e,SystemParams)

% Erased state (fixed gaussian)
top = exp(-1.*((y-mu_e).^2)./(2.*sigma_e.^2));

% Programmed state (Varies; depends on N)
[mu_p,sigma_p] = getRetentionParams(SystemParams.N,SystemParams.t,...
    SystemParams.Vp,SystemParams.Verased);
% Uniform distribution:
a = SystemParams.Vp;
b = SystemParams.Vp + SystemParams.deltaVp;

bottom = (normcdf((x-a),mu_p,sigma_p) - normcdf((x-b),mu_p,sigma_p))./(b-a);

L = log(top./bottom);

end