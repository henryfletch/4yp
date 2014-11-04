function p = errorbars(type,r,n)

if strcmp(type,'pos')
    p = (r./n).*exp(2.*sqrt((n-r)./(r.*n)));
elseif strcmp(type,'neg')
    p = (r./n).*exp(-2.*sqrt((n-r)./(r.*n)));
else
    error('Incorrect input argument!');
end
end