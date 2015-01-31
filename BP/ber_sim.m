function ber_sim(varargin)

if isstr(varargin{1})
    EbNo = str2double(varargin{1});
else
    EbNo = varargin{1};
end

[~,randomID] = strtok(tempname,'_');
filename = strcat('output_files/',varargin{2},randomID,'.txt');

% LDPC Monte-Carlo Run Script

%%%%%%%%%%%%%%%% SETTINGS %%%%%%%%%%%%%%%

% Parity Check Matrix (H)
H = load('../LDPC data/Rate0.5/H-96-48-v2.mat');
% Generator Matrix (G)
G = load('../LDPC data/Rate0.5/G-96-48-v2.mat');

% Belief Propogation Max Iterations
l = 50;
% MinSum Convergence Factor
convergFactor = 0.8;

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

for i = 1:1000
%Run the decoder
[~,errRatio(i),~] = ldpc_BER_minsum_AWGN(G,H,l,sigma2,convergFactor);
end

fid=fopen(filename,'a+');
fprintf(fid,'%e\n',mean(errRatio));

end
