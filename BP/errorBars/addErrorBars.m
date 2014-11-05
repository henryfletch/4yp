%I matrix: ((1)SNR, (2)MC simulations, (3)BP iterations, (4)# block fails, (5)err prob)
%Takes I and adds two additional columns with lengths of +/- error bars

function I = addErrorBars(I)

r = I(:,4); %Block errors per simulation
n = I(:,2); %Total blocks per simulation
I(:,6) = calcErrorBars('pos',r,n); %p+ value
I(:,7) = calcErrorBars('neg',r,n); %p- value
I(:,6) = I(:,6) - I(:,8); %P+ length is p+ - y(blockErr)
I(:,7) = I(:,8) - I(:,7); %P- length is y(blockErr) - p-

end