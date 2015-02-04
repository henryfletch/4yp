% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function error_ratio = ZZ_ldpc_BER_memoryN_coded(Rc,hEnc,hDec,hError,SystemParams,voltageHardDecision)

% Input vector
dataIn = randi([0,1],64800*Rc,1);

%Encode multiple blocks at same time

encodedData = step(hEnc,dataIn);

%Convert to a cell voltage level
y = memoryGetVoltage(encodedData,SystemParams);
%y = memoryGetVoltage_mex(encodedData,SystemParams.tYrs,SystemParams.Verased, ...
%    SystemParams.Vp,SystemParams.deltaVp,SystemParams.N);

% HARD DECISION process on Cell Voltage
% > vHardDecision, then binary 1 (LLR -50), otherwise binary 0 (LLR +50)
y(y <= voltageHardDecision) = 50;
y(y < 50) = -50;

% Belief Propogation Stage
receivedBits = step(hDec, y');
receivedBits = +receivedBits;
% Iterates on LLR, outputs binary 1,0


errorStats = step(hError, encodedData, receivedBits);
error_ratio = errorStats(1);


end