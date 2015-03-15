function ebno = test_EbNo(N)

t = 5*365*24*3600;
Vp = 2.8;
deltaVp = 0.25;
Verased = 1.4;

for i = 1:length(N)
    [mu,sigma] = getRetentionParams(N(i),t,Vp,Verased);
    ratioProg = (Vp+mu)^2/((1/12)*deltaVp^2 + 2*(0.00025*N(i)^0.5)^2 + 2*sigma^2);
    ratioErase  = (Verased^2)/(2*0.35^2 + 2*(0.00025*N(i)^0.5)^2);
    ebno(i) = 10*log10((ratioProg+ratioErase)/2);
end

end
