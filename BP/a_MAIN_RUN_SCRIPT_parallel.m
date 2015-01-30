function a_MAIN_RUN_SCRIPT_parallel(varargin)

if isstr(varargin{1})
    EbNo = str2double(varargin{1});
else
    EbNo = varargin{1};
end

filename = varargin{2};
fid=fopen(filename,'a+');


% LDPC Monte-Carlo Run Script
clear
close
addpath('./minSum');

%%%%%%%%%%%%%%%% SETTINGS %%%%%%%%%%%%%%%

% Parity Check Matrix (H)
H = load('../LDPC data/Rate0.5/H-96-48-v2.mat');
% Generator Matrix (G)
G = load('../LDPC data/Rate0.5/G-96-48-v2.mat');

% Belief Propogation Max Iterations
l = 50;
% MinSum Convergence Factor
convergFactor = 0.7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H = sparse(H.H);
G = sparse(G.G);

% Modulation Rate
Rm = 1; %Always 1 for BPSK
% Code Rate Calculation
[m,n] = size(G);
Rc = m/n;

% Noise Variance Extraction
sigma2 = getVariance(EbNo,Rc,Rm);

%Run the single decode
[~,errRatio,~] = ldpc_BER_AWGN(G,H,l,sigma2);

fprintf(fid,errRatio);

end
