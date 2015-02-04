%This function returns a sampled voltage level from the memory model,
%dependent on binary 1 or binary 0 as the input.
% INPUTS:
% b, binary value
% SystemParams - Structure; system parameters
%   -N, P/E Cycles
%   -tYrs, retention time
%   -Verased, mean erased voltage level
%   -Vp, programmed voltage start value
%   -deltaVp, programmed voltage step width
% retentionData - Structure; retention process values

function y = memoryGetVoltage(b,SystemParams,retentionData)

% Samples: Generate enough for all zero and all one case, i.e. length(b)
samples = length(b);
% Time conversion
t = SystemParams.tYrs*365*24*3600;

% Random Telegraph Noise
% RTN will be a vector, size of length(b)
lambda = 0.00025*SystemParams.N^0.5;
RTN = gen_laplacian(lambda,samples);

% Retention Process
% retention will be a vector, size of length(b)
[mu_d,sigma_d] = getRetentionParams(SystemParams.N,t,SystemParams.Vp,SystemParams.Verased,retentionData);
retention = gen_gaussian(mu_d,sigma_d,samples);

% Programmed state (Vector)
V0 = gen_uniform(SystemParams.Vp,SystemParams.Vp+SystemParams.deltaVp,samples);

% Erased state (Vector)
Ve = gen_gaussian(SystemParams.Verased,0.35,samples);

%%%
% Matrix of vectors
y_bin1 = V0 + RTN + retention;
y_bin0 = Ve + RTN;

y = b.*y_bin1 + ~b.*y_bin0;
y=y';
end


