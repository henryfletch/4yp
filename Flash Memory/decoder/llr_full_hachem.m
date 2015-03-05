function L = llr_full_hachem(y,mu_e,sigma_e,SystemParams)

t = SystemParams.tYrs*365*24*3600;

% Erased state (fixed gaussian)
top = exp(-1.*((y-mu_e).^2)./(2.*sigma_e.^2));

% Programmed state (Varies; depends on N)
[mu_p,sigma_p] = getRetentionParams(SystemParams.N,t,...
    SystemParams.Vp,SystemParams.Verased);
% Uniform distribution:
a = SystemParams.Vp;
b = SystemParams.Vp + SystemParams.deltaVp;
% Laplacian
lambda = 0.00025*SystemParams.N^0.5;

bottom = hachem_conv(y,mu_p,sigma_p,SystemParams,lambda);

L = log(top./bottom);

end