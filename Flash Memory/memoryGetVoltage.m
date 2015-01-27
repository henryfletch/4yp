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

% Samples = 1, SISO function
samples = 1;
% Time conversion
t = SystemParams.tYrs*365*24*3600;

% Random Telegraph Noise
lambda = 0.00025*SystemParams.N^0.5;
RTN = gen_laplacian(lambda,samples);

if b == 1
    % Programmed state
    V0 = gen_uniform(SystemParams.Vp,SystemParams.Vp+SystemParams.deltaVp,samples);
    % Retention Process (Only applies if b == 1)
    [mu_d,sigma_d] = getRetentionParams(SystemParams.N,t,SystemParams.Vp,SystemParams.Verased,retentionData);
    retention= gen_gaussian(mu_d,sigma_d,samples);
    % Add noise
    y = V0 + RTN + retention;
    
elseif b == 0
    % Erased state
    Ve = gen_gaussian(SystemParams.Verased,0.35,samples);
    % Add noise
    y = Ve + RTN;
else
    y = NaN;
    warning('Input not recognised!');
end

end


