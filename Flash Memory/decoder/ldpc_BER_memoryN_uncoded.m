% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function [biterr_num,biterr_ratio] = ldpc_BER_memoryN_uncoded(SystemParams,retentionData,voltageHardDecision)

% Input vector
dataIn = randi([0,1],1,64800-6480);

% %Encode
% x = bp_encoder(x,H);
% x=x';
% x_encoded = x;

%Convert to a cell voltage level
y = memoryGetVoltage(dataIn,SystemParams,retentionData);

% Belief Propogation Stage
%[y,iterations] = BP_iterate_minsum(x,H,l);

% HARD DECISION process on Cell Voltage
% > 2.5v, then binary 1, otherwise binary 0
for i = 1:length(y)
    if y(i) > voltageHardDecision
        y(i) = 1;
    else
        y(i) = 0;
    end
end

[biterr_num,biterr_ratio] = biterr(dataIn,y);

end