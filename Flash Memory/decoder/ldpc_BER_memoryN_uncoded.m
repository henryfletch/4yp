% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function [biterr_num,biterr_ratio] = ldpc_BER_memoryN_uncoded(SystemParams,voltageHardDecision)

% Input vector
dataIn = randi([0,1],64800,1);

%Convert to a cell voltage level
y = memoryGetVoltage(dataIn,SystemParams);
%y = memoryGetVoltage_mex(encodedData,SystemParams.tYrs,SystemParams.Verased, ...
%    SystemParams.Vp,SystemParams.deltaVp,SystemParams.N);

% HARD DECISION process on Cell Voltage
% > vHardDecision, then binary 1 (LLR -50), otherwise binary 0 (LLR +50)
y(y <= voltageHardDecision) = 0;
y(y > 0) = 1;

[biterr_num,biterr_ratio] = biterr(dataIn,y');

end