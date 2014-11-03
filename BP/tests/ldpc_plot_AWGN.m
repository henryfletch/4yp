%clear

%Input Data, Z
U = load('./SavedGraphData/AWGN-uncoded-0to6dB.mat'); %Uncoded
Z = load('./SavedGraphData/0.5-1008-504-AWGN-3.mat'); %1008x504 LDPC
Z2 = load('./SavedGraphData/0.5-96-48-AWGN-upto5.43.mat'); %96x48 LDPC


%Extract x and y
x = (Z.Z(:,1));
y = smooth(Z.Z(:,2));
x_2 = (Z2.Z(:,1));
y_2 = smooth(Z2.Z(:,2));
x_unenc = U.U(:,1);
y_unenc = U.U(:,2);

%Semilog Plots
uncoded = semilogy(x_unenc,y_unenc,'DisplayName','Uncoded','LineWidth',1.5);
hold on
grid on
coded1 = semilogy(x,y,'DisplayName','n=1008 r=0.5 LDPC','LineWidth',1.5);
coded2 = semilogy(x_2,y_2,'DisplayName','n=96 r=0.5 LDPC','LineWidth',1.5);
xlabel('SNR (dB)');
ylabel('BER');
title('AWGN Channel - Performance Curves');
lgnd = legend([uncoded coded2 coded1]);
set(lgnd,'FontSize',12,'Location','SouthWest');
