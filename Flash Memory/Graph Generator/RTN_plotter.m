clear all;close all

x = -2.5:0.0001:2.5;

% N = 50,000
y = mem_RTN(x,50000);
plot(x,y)
axis([-0.8 0.8 0 10])
hold on

% N = 100,000
y = mem_RTN(x,100000);
plot(x,y)
hold on

% N = 200,000
y = mem_RTN(x,200000);
plot(x,y)