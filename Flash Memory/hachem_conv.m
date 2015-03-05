function y = hachem_conv(x,mu_r,sigma_r,SystemParams,lambda)

deltaVp = SystemParams.deltaVp;
Vp = SystemParams.Vp;

var1 = x - Vp - deltaVp - mu_r;
var2 = (sigma_r^2/(2*lambda^2));
var3 = x - Vp - mu_r;

y = (1/(4*deltaVp)).*exp(var2).*(exp(-var1/lambda).*erfc((sigma_r/(sqrt(2)*lambda))-(var1/(sqrt(2)*sigma_r)))...
    - exp(var1/lambda).*erfc((sigma_r/(sqrt(2)*lambda))+(var1/(sqrt(2)*sigma_r)))) ...
    - (1/(4*deltaVp)).*exp(var2).*(exp(-var3/lambda).*erfc((sigma_r/(sqrt(2)*lambda))-(var3/(sqrt(2)*sigma_r))) ...
    - exp(var3/lambda).*erfc((sigma_r/(sqrt(2)*lambda))+var3/(sqrt(2)*sigma_r))) ...
    + (1/(2*deltaVp)).*erfc(var1/(sqrt(2)*sigma_r)) - (1/(2*deltaVp)).*erfc(var3/(sqrt(2)*sigma_r));

end