function ZZ_run_sim(varargin)
if isstr(varargin{1})
    N = str2double(varargin{1});
else
    N = varargin{1};
end

[~,randomID] = strtok(tempname,'_');
filename = strcat(varargin{2},randomID,'.txt');

% LDPC Graphing Run Script
% FIXED t, VARIABLE N

addpath('../Random Generators');
addpath('../.');

% System Parameters
SystemParams.tYrs = 5;
SystemParams.Verased = 1.4;
SystemParams.Vp = 2.8;
SystemParams.deltaVp = 0.25;

% Retention Parameters
retentionData.Ks = 0.38;
retentionData.Kd = 4e-4;
retentionData.Km = 4e-6;
retentionData.t0 = 3600;

%Code Rate
Rc = 9/10;

%DVB-S2 Parity check matrix
H = dvbs2ldpc(Rc);

% MC Simulation Runs
mc_iters = 10;

% Loop to go over all values of EbNo, as well as perform MC Simulation
I = [];
    hEnc = comm.LDPCEncoder(H);
    hDec = comm.LDPCDecoder('ParityCheckMatrix',H,'IterationTerminationCondition',...
        'Parity check satisfied','OutputValue','Whole codeword');
    hError = comm.ErrorRate;

    SystemParams.N = N;
    voltageHardDecision = decisionFunc(N);
    %for Loop
    for i = 1:mc_iters
        errRatio(i) = ZZ_ldpc_BER_memoryN_coded(Rc,hEnc,hDec,hError,SystemParams,retentionData,voltageHardDecision);
    end

fid=fopen(filename,'a+');
fprintf(fid,'%e\n',mean(errRatio));

end
