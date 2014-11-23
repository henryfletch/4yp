clear

%Input Data, Z

Z = load('./SavedGraphData/0.7-273-193-AWGN-scale4.mat'); 
Z2 = load('./SavedGraphData/0.7-273-193-AWGN-noscale.mat');
R = load('../LDPC data/Rate0.7/0.7-273-192-results.mat'); 

% Uncoded function generator
x_unenc = -1:0.01:6;
x_unenc = 10.^(x_unenc./10);
y_unenc = 0.5*erfc(sqrt(x_unenc));
x_unenc = 10*log10(x_unenc); 

%Extract x and y
x = Z.I(:,1) - 3;
y = Z.I(:,3);
x_2 = Z2.I(:,1) - 3;
y_2 = Z2.I(:,3);
x_results = R.EbNodB;
y_results = R.bit_ep;

%Semilog Plots
uncoded = semilogy(x_unenc,y_unenc,'DisplayName','Uncoded','LineWidth',1.5);
hold on
grid on
coded1 = semilogy(x,y,'DisplayName','r=0.7, n=273, Input Scale Factor 4','LineWidth',1.5);
coded2 = semilogy(x_2,y_2,'DisplayName','r=0.7, n=273, appx 1000 BP iterations','LineWidth',1.5);
results = semilogy(x_results,y_results,'DisplayName','r=0.7, n=273 MacKay Results','LineWidth',1.5);
xlabel('Eb/No (dB)');
ylabel('Bit Error Probability');
title('AWGN Channel - Performance Curves');
lgnd = legend([uncoded coded1 coded2 results]); % coded1 coded3]);
set(lgnd,'FontSize',12,'Location','SouthWest');
