function p = errorbars(type,r,n)

if strcmp(type,'pos')
    p = (r/n)*exp(2*sqrt((n-r)/(r*n)));
else
    p = (r/n)*exp(-2*sqrt((n-r)/(r*n)));
end
end