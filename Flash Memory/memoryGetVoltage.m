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

% Now loop through b, detect if 1 or 0, then add correct noise
y = zeros(1,length(b));
for i = 1:length(b)
    
    if b(i) == 1
        % Get Voltage for binary 1
        y(i) = V0(i) + RTN(i) + retention(i);
        
    elseif b(i) == 0
        % Get Voltage for binary 0
        y(i) = Ve(i) + RTN(i);
    else
        error('Something very bad happened!');
    end
    
end
end


