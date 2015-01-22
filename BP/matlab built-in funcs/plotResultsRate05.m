clear

%Input Data, Z

my = load('./DVBS2 Results/myDecoder-rate0.5.mat');
matlab = load('./DVBS2 Results/matlabDecoder-rate0.5.mat');

% Uncoded function generator
x_unenc = -6:0.01:7;
x_unenc = 10.^(x_unenc./10);
y_unenc = 0.5*erfc(sqrt(x_unenc));
x_unenc = 10*log10(x_unenc); 

%Extract x and y
my_x = my.I(:,1) - 10*log10(1/0.5);
my_y = my.I(:,3);
matlab_x = matlab.I(:,1);
matlab_y = smooth(matlab.I(:,2));

%Semilog Plots
my = semilogy(my_x,my_y,'DisplayName','N=64800,Rate=0.5,Personal Decoder','LineWidth',1.5);
hold on
grid on
matlab = semilogy(matlab_x,matlab_y,'DisplayName','N=64800,Rate=0.5,Matlab decoder','LineWidth',1.5);
uncoded = semilogy(x_unenc,y_unenc,'DisplayName','Uncoded','LineWidth',1.5);
xlabel('Eb/No (dB)');
ylabel('Bit Error Probability');
title('AWGN Channel - Performance Curves');
lgnd = legend([uncoded matlab my]); % coded1 coded3]);
set(lgnd,'FontSize',12,'Location','SouthWest');
axis([-6 6 10e-9 1])
