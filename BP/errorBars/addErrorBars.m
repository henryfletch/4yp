%I matrix: ((1)SNR, (2)MC simulations, (3)BP iterations, (4)# block fails, (5)err prob)
%Takes I and adds two additional columns with lengths of +/- error bars

function I = addErrorBars(I)

r = I(:,4); %Block errors per simulation
n = I(:,2); %Total blocks per simulation
I(:,6) = calcErrorBars('pos',r,n); %p+ value
I(:,7) = calcErrorBars('neg',r,n); %p- value
I(:,6) = I(:,6) - I(:,5); %P+ length is p+ - y
I(:,7) = I(:,5) - I(:,7); %P- length is y - p-

end