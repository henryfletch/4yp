% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function [biterr_num,biterr_ratio,iterations] = ldpc_BER_memoryN_coded(Rc,H,l,SystemParams,retentionData,voltageHardDecision)

% Input vector
dataIn = randi([0,1],1,64800*Rc);

%Encode
x = bp_encoder(dataIn,H);
x=x';
x_encoded = x;

%Convert to a cell voltage level
y = memoryGetVoltage(x,SystemParams,retentionData);

% HARD DECISION process on Cell Voltage
% > vHardDecision, then binary 1 (LLR -1), otherwise binary 0 (LLR +1)
for i = 1:length(y)
    if y(i) > voltageHardDecision
        y(i) = -10;
    else
        y(i) = 10;
    end
end

% Belief Propogation Stage
[y,iterations] = BP_iterate_minsum(y,H,l);
% Iterates on LLR, outputs LLR

% HARD DECISION process on output LLR
for i = 1:length(y)
    if y(i) > 0
        y(i) = 0;
    else
        y(i) = 1;
    end
end

[biterr_num,biterr_ratio] = biterr(x_encoded,y);

end