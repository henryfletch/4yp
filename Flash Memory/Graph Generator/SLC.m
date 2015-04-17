%test script

clear all
close all
I = [];
x = -5:0.0001:5;
NVector = [20000];
Verased = 1.4;
Vp = 2.8;
deltaVp = 0.25;
timeYrs = 5;

time = timeYrs*365*24*3600;

%Erased State
yErased = normpdf(x,Verased,0.35);

%Initial Programmed State Vp
yProgrammed = mem_programState(x,Vp,deltaVp);

for N = NVector
%Noise functions
yRTN = mem_RTN(x,N);
yRetention = mem_retention(x,time,N,Verased,Vp);

%Noised programme distribution
output1 = conv(yProgrammed,yRTN,'same');
output2 = conv(output1,yRetention,'same');

%Noised erased distribution
output4 = conv(yErased,yRTN,'same');
%output4 = conv(output3,yRetention,'same');

%Normalise area = 1
area2 = trapz(x,output2);
output2 = output2/area2;

area4 = trapz(x,output4);
output4 = output4/area4;

I = [I;{output2},{output4}]; % Programmed, Erased
end

[numplots,~] = size(I);
numplots = numplots+1;

% Original PDFs
subplot(numplots,1,1)
plot(x,yProgrammed)
hold on
plot(x,yErased)
axis([0 3.5 0 5])
title('t=0,N=0');

for i  = 2:numplots
% Noisy PDFs
subplot(numplots,1,i)
prog = I{i-1,1};
erase = I{i-1,2};
plot(x,prog)
hold on
plot(x,erase)
axis([0 3.5 0 5])
N = NVector(i-1);
title(['t = ',num2str(timeYrs),' yrs, N = ',num2str(N),' P/E cycles'])
end
