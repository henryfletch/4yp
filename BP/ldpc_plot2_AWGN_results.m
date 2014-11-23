clear

%Input Data, Z

Z = load('./SavedGraphData/0.7-273-193-AWGN-scale4.mat'); 
Z2 = load('./SavedGraphData/0.7-273-193-AWGN-noscale.mat');
R = load('../LDPC data/Rate0.7/0.7-273-192-results.mat'); 

% Uncoded function generator
x_unenc = -3:0.01:6;
x_unenc = 10.^(x_unenc./10);
y_unenc = 0.5*erfc(sqrt(x_unenc));
x_unenc = 10*log10(x_unenc); 

%Extract x and y
x = Z.I(:,1) - 3;
y = Z.I(:,3);
%x_3 = Z3.Z(:,1);
%y_3 = Z3.Z(:,2);
x_results = R.EbNo;
y_results = R.bit_ep;

%Semilog Plots
uncoded = semilogy(x_unenc,y_unenc,'DisplayName','Uncoded','LineWidth',1.5);
hold on
grid on
coded1 = semilogy(x,y,'DisplayName','r=0.7, n=273, Input Scale Factor 4','LineWidth',1.5);
coded2 = semilogy(x_2,y_2,'DisplayName','n=96 r=0.5 LDPC','LineWidth',1.5);
%coded3 = semilogy(x_3,y_3,'DisplayName','n=9972 r=0.5 irregular LDPC','LineWidth',1.5);
results = semilogy(x_results,y_results,'DisplayName','n=96 r=0.5 LDPC MacKay Results','LineWidth',1.5);
xlabel('Eb/No (dB)');
ylabel('Bit Error Probability');
title('AWGN Channel - Performance Curves');
lgnd = legend([uncoded coded2 results]); % coded1 coded3]);
set(lgnd,'FontSize',12,'Location','SouthWest');
