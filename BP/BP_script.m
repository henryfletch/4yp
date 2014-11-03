% Belief Propogation Run Script

clear
close

% Iterations
l = 15;

% Message vector of Log-Likelihood ratios
% Originally [1 0* 0 1 0 1 0 1] *=flipped
x = [-1,1,1,-1,1,-1,1,-1];

% "Parity Check Matrix" or graph connections
% Rows = Each Check node
% Cols = Each Message node
H = [0 1 0 1 1 0 0 1
    1 1 1 0 0 1 0 0
    0 0 1 0 0 1 1 1
    1 0 0 1 1 0 1 0];

%%%%

y = BP_iterate(x,H,l);

x
y   