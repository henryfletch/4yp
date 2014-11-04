r = I(:,4)*500;
n = ones(49,1)*500;
I(:,5) = errorbars('pos',r,n);
I(:,6) = errorbars('neg',r,n);
I(:,5) = I(:,5) - I(:,4);
I(:,6) = I(:,4) - I(:,6);