function ebno = test_EbNo(N)

t = 5*365*24*3600;
Vp = 2.8;
deltaVp = 0.25;
Verased = 1.4;

for i = 1:length(N)
    [mu,sigma] = getRetentionParams(N(i),t,Vp,Verased);
    ratio = ((2*Vp + deltaVp)^2)/(16*sigma^2);
    ebno(i) = 10*log10(ratio);
end

end
