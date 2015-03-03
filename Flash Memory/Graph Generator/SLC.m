%test script

clear
close

x = -5:0.0001:5;
N = 5000;
Verased = 1.4;
Vp = 2.6;
deltaVp = 0.25;
timeYrs = 50;

time = timeYrs*365*24*3600;

%Erased State
yErased = normpdf(x,Verased,0.35);

%Initial Programmed State Vp
yProgrammed = mem_programState(x,Vp,deltaVp);

%Noise functions
yRTN = mem_RTN(x,N);
yRetention = mem_retention(x,time,N,Verased,Vp);

test = conv(yRTN,yRetention,'same');

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

% Noisy PDFs
subplot(2,1,2)
plot(x,output2)
hold on
plot(x,output4)
axis([0 5 0 10])
title(['t = ',num2str(timeYrs),' yrs, N = ',num2str(N),' P/E cycles'])

% Original PDFs
subplot(2,1,1)
plot(x,yProgrammed)
hold on
plot(x,yErased)
axis([0 5 0 10])
title('t=0,N=0');

