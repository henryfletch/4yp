clear

%Input Data, Z
U = load('./SavedGraphData/AWGN-uncoded-0to6dB.mat'); %Uncoded
%Z = load('./SavedGraphData/0.5-1008-504-AWGN-3.mat'); %1008x504 LDPC
Z2 = load('./SavedGraphData/0.5-96-48-AWGN-3.mat'); %96x48 LDPC
%Z3 = load('./SavedGraphData/0.5-9972-4986-AWGN.mat'); %Irregular 9972x4986
R = load('../LDPC data/Rate0.5/results-96-48.mat'); %96x48 LDPC results data

%Extract x and y
%x = Z.Z(:,1);
%y = smooth(Z.Z(:,2));
x_2 = Z2.I(:,1) - 3;
y_2 = Z2.I(:,3);
%x_3 = Z3.Z(:,1);
%y_3 = Z3.Z(:,2);
x_unenc = U.U(:,1) - 3;
y_unenc = U.U(:,2);
x_results = R.EbNo_bit_ep(:,1)- R.x; %SNR correction: MacKay is non-zero SNR
y_results = R.EbNo_bit_ep(:,2);

%Semilog Plots
uncoded = semilogy(x_unenc,y_unenc,'DisplayName','Uncoded','LineWidth',1.5);
hold on
grid on
%coded1 = semilogy(x,y,'DisplayName','n=1008 r=0.5 LDPC','LineWidth',1.5);
coded2 = semilogy(x_2,y_2,'DisplayName','n=96 r=0.5 LDPC','LineWidth',1.5);
%coded3 = semilogy(x_3,y_3,'DisplayName','n=9972 r=0.5 irregular LDPC','LineWidth',1.5);
results = semilogy(x_results,y_results,'DisplayName','n=96 r=0.5 LDPC MacKay Results','LineWidth',1.5);
xlabel('Eb/No (dB)');
ylabel('Bit Error Probability');
title('AWGN Channel - Performance Curves');
lgnd = legend([uncoded coded2 results]); % coded1 coded3]);
set(lgnd,'FontSize',12,'Location','SouthWest');
