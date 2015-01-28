% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function error_ratio = ZZ_ldpc_BER_memoryN_coded(Rc,hEnc,hDec,hError,SystemParams,retentionData,voltageHardDecision)

% Input vector
dataIn = randi([0,1],1,64800*Rc);
dataIn = dataIn';
%Encode
encodedData = step(hEnc, dataIn);

%Convert to a cell voltage level
y = memoryGetVoltage(encodedData,SystemParams,retentionData);
y=y';

% HARD DECISION process on Cell Voltage
% > vHardDecision, then binary 1 (LLR -1), otherwise binary 0 (LLR +1)
for i = 1:length(y)
    if y(i) > voltageHardDecision
        y(i) = -50;
    else
        y(i) = 50;
    end
end

% Belief Propogation Stage
receivedBits = step(hDec, y);
receivedBits = +receivedBits;
% Iterates on LLR, outputs LLR


errorStats = step(hError, encodedData, receivedBits);
error_ratio = errorStats(1);


end