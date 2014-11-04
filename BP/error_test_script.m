r = I(:,4)*500;
n = ones(51,1)*500;
I(:,5) = errorbars('pos',r,n);
I(:,6) = errorbars('neg',r,n);