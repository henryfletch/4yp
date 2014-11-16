clear

%Input Data, Z
%U = load('./SavedGraphData/AWGN-uncoded-0to9dB.mat'); %Uncoded
Z = load('./SavedGraphData/0.7-273-193-AWGN.mat'); %273x193 Rate = 0.7 LDPC
Z2 = load('./SavedGraphData/0.87-3584-3141-AWGN.mat'); %3584x3141 Rate = 0.8 LDPC
%Z3 = load('./SavedGraphData/0.5-9972-4986-AWGN-2.mat'); %Irregular 9972x4986 Rate = 0.5 LDPC
Z4 = load('./SavedGraphData/0.5-1008-504-AWGN-6.mat'); %1008x504 LDPC (CORRECTED!)
R = load('../LDPC data/Rate0.7/0.7-273-192-results.mat'); %273x192 results structure
R2 = load('../LDPC data/Rate0.876/results-3584-3140.mat'); %96x48 LDPC results data

% Uncoded function generator
x_unenc = -3:0.01:6;
x_unenc = 10.^(x_unenc./10);
y_unenc = 0.5*erfc(sqrt(x_unenc));
x_unenc = 10*log10(x_unenc); 

%Extract x and y
x = Z.I(:,1) - 3;
y = Z.I(:,3);
x_2 = Z2.I(:,1) - 3;
y_2 = Z2.I(:,3);
%x_3 = Z3.I(:,1) - 3;
%y_3 = Z3.I(:,3);
x_4 = Z4.I(:,1) - 3;
y_4 = Z4.I(:,3);
xr1 = R.EbNodB - R.x;
yr1 = R.bit_ep;
xr2 = R2.EbNodB - R2.x;
yr2 = R2.bit_ep;

%Semilog Plots
uncoded = semilogy(x_unenc,y_unenc,'DisplayName','Uncoded','LineWidth',1.5);
hold on
grid on
coded1 = semilogy(x,y,'DisplayName','n=273 r=0.7 LDPC','LineWidth',1.5);
coded2 = semilogy(x_2,y_2,'DisplayName','n=3584 r=0.87 LDPC','LineWidth',1.5);
%coded3 = semilogy(x_3,y_3,'DisplayName','n=9972 r=0.5 LDPC','LineWidth',1.5);
%coded4 = semilogy(x_4,y_4,'DisplayName','n=1008 r=0.5 LDPC','LineWidth',1.5);
results1 = semilogy(xr1,yr1,'DisplayName','n=273 r=0.7 McKay Results','LineWidth',1.5);
results2 = semilogy(xr2,yr2,'DisplayName','n=3584 r=0.87 McKay Results','LineWidth',1.5);
xlabel('Eb/No (dB)');
ylabel('Bit Error Probability');
title('AWGN Channel - Performance Curves');
lgnd = legend([uncoded coded1 coded2 results1 results2]);
set(lgnd,'FontSize',12,'Location','SouthWest');
xlim([-1 6])