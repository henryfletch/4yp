clear
A = load('errorBars/errorbars-data2.mat'); %96x48 code
B = load('SavedGraphData/0.5-1008-504-AWGN-4.mat'); %1008x504 code

A.x = A.I(:,1) - 3;
A.iter = A.I(:,3);
B.x = B.I(:,1) - 3;
B.iter = B.I(:,2);

myX = [-3,4];
myY = [15,15];

graphA = plot(A.x,A.iter,'DisplayName','n=96 r=0.5 LDPC','LineWidth',1.5);
hold on; grid on;
graphB = plot(B.x,B.iter,'DisplayName','n=1008 r=0.5 LDPC','LineWidth',1.5);
baseLine = plot(myX,myY,'--','color','blue','DisplayName','Original Setting');
xlabel('Eb/No (dB)');
ylabel('Iterations');
title('Iterations of Belief Propogation until stop (Condition: All LLRs +/- Inf)');
lgnd = legend([baseLine graphA graphB]);
set(lgnd,'FontSize',12,'Location','NorthEast');