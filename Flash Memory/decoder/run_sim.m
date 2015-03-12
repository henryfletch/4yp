function run_sim(varargin)

if isstr(varargin{1})
    N = str2double(varargin{1});
else
    N = varargin{1};
end

[~,randomID] = strtok(tempname,'_');
filename = strcat('output_files/',varargin{2},randomID,'.txt');

% Ensures truly random numbers for each process
% seed is now a random number that can be used to initialise rand
%fid2 = fopen('/dev/random');
%seed = fread(fid2, 1, 'uint32');
%RandStream.setDefaultStream(RandStream('mt19937ar','seed',seed));

% LDPC Graphing Run Script
% FIXED t, VARIABLE N

%addpath('../Random Generators');
%addpath('../.');

% System Parameters
SystemParams.tYrs = 5;
SystemParams.Verased = 1.4;
SystemParams.Vp = 2.8;
SystemParams.deltaVp = 0.25;
SystemParams.tSecs = SystemParams.tYrs*365*24*3600;

%%% DVB-S2 CODES %%%
%Code Rate
Rc = 9/10;
%Code size
Nc = 64800;
%DVB-S2 Parity check matrix
H = dvbs2ldpc(Rc);

%%% TOSHIBA PEG CODES %%%
%addpath('../../LDPC data/Toshiba');
% H = load('H-4095-3367.mat');
% H = H.H;
% G = load('G-4095-3367.mat');
% G = G.G;
% Nc = 4095;
% Rc = 3367/4095;

% Blocks per program
mc_iters = 1000;
l = 50;

hEnc = fec.ldpcenc(H);
hDec = fec.ldpcdec(H);
hDec.DoParityChecks = 'Yes';
hDec.DecisionType = 'Hard decision';
hDec.OutputFormat = 'Whole codeword';
hDec.NumIterations = 50;

SystemParams.N = N;
voltageHardDecision = 0;%decisionFunc(N);

%for Loop
for i = 1:mc_iters
    errRatio(i) = ldpc_BER_memoryN_coded_sim(Rc,Nc,hEnc,hDec,SystemParams,voltageHardDecision,H,l);
end

fid=fopen(filename,'a+');
fprintf(fid,'%e\n',mean(errRatio));

end
