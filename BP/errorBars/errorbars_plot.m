clear
close

errorData = load('errorbars-data2.mat');
I = errorData.I;

x = I(:,1) - 3;
y = I(:,8); % BLOCK ERROR PROBABILITY NOT BER!
iter = I(:,3);
u = I(:,6);
l = I(:,7);

graph = semilogy(x,y,'DisplayName','n=96 r=0.5 LDPC','LineWidth',1.5);
hold on
grid on
errorbar(x,y,l,u,'b');
xlabel('Eb/No (dB)');
ylabel('Block Error Probability');
title('AWGN Channel - Block Error Probabilty w/Error Bars ');
lgnd = legend([graph]);
set(lgnd,'FontSize',12,'Location','SouthWest');