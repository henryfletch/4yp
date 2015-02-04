% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function error_ratio = ZZ_GPU_ldpc_BER_memoryN_coded(Rc,hEnc,hDec,hError,SystemParams,retentionData,voltageHardDecision)

numBlocks = 10;

% Input vector
dataIn = randi([0,1],64800*Rc,numBlocks);

%Encode multiple blocks at same time
for ii = 1:numBlocks
    encodedData = step(hEnc, dataIn(:,ii));
    encodedData_matrix(:,ii) = encodedData;
    
    %Convert to a cell voltage level
    y = memoryGetVoltage(encodedData,SystemParams,retentionData);
    
    % HARD DECISION process on Cell Voltage
    % > vHardDecision, then binary 1 (LLR -50), otherwise binary 0 (LLR +50)
    for i = 1:length(y)
        if y(i) > voltageHardDecision
            y(i) = -50;
        else
            y(i) = 50;
        end
    end
    y_matrix(:,ii) = y;
end

% Belief Propogation Stage
receivedBits = step(hDec, y_matrix(:));
receivedBits = +receivedBits;
% Iterates on LLR, outputs binary 1,0


errorStats = step(hError, encodedData_matrix(:), receivedBits);
error_ratio = errorStats(1);


end