%clear

%Input Data, Z
Z = load('./SavedGraphData/0.5-1008-504-BSC.mat'); %1008x504 LDPC
Z2 = load('./SavedGraphData/0.5-96-48-BSC-2.mat'); %96x48 LDPC

%Produce the uncoded case, y = x (i.e. BER = BSC Probability?)
x_unenc = 0:0.001:0.05;
y_unenc = x_unenc;

%Extract x and y
x = Z.Z(:,1);
y = smooth(Z.Z(:,2));
x_2 = Z2.Z(:,1);
y_2 = smooth(Z2.Z(:,2));

%Plots
uncoded = plot(x_unenc,y_unenc,'DisplayName','Uncoded','LineWidth',1.5);
hold on
grid on
coded1 = plot(x,y,'DisplayName','n=1008 r=0.5 LDPC','LineWidth',1.5);
coded2 = plot(x_2,y_2,'DisplayName','n=96 r=0.5 LDPC','LineWidth',1.5);
xlabel('BSC Probability');
ylabel('BER');
title('Binary Symmetric Channel - Performance Curves');
axis([0 0.05 0 0.08]);
lgnd = legend([uncoded coded2 coded1]);
set(lgnd,'FontSize',12,'Location','NorthWest');
