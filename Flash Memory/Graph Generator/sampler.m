Vp = 2.6;
y = output2;

% y is a vector of the noise-affected PDF values
% First, need to locate where the hard decision point is
% For now, let that = Vp, the initial threshold voltage
% i.e. if y(x) > Vp --> Binary 1
% if y(x) < Vp --> Binary 0

indexPoint = find(x == Vp); % Find the cutoff point

areaBinary1 = trapz(x(indexPoint:end),y(indexPoint:end));
areaBinary0 = 1 - areaBinary1; %Area adds up to 1

binaryOutput = (rand(1,1)<=areaBinary1)