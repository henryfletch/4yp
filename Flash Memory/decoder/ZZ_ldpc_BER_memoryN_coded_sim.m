% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function error_ratio = ZZ_ldpc_BER_memoryN_coded_sim(Rc,hEnc,hDec,SystemParams,voltageHardDecision)

% Input vector
dataIn = randi([0,1],1,64800*Rc);

%Encode multiple blocks at same time

encodedData = encode(hEnc,dataIn);

%Convert to a cell voltage level
y = memoryGetVoltage(encodedData,SystemParams);
%y = memoryGetVoltage_mex(encodedData,SystemParams.tYrs,SystemParams.Verased, ...
%    SystemParams.Vp,SystemParams.deltaVp,SystemParams.N);

% HARD DECISION process on Cell Voltage
% > vHardDecision, then binary 1 (LLR -50), otherwise binary 0 (LLR +50)
y(y <= voltageHardDecision) = 50;
y(y < 50) = -50;

% SOFT DECISION -> Generate a LLR using gaussian approximation
% L is the vector of log liklehood ratios
%L = llr(y,SystemParams.Verased,0.35,SystemParams.Vp,0.2);

% Belief Propogation Stage
receivedBits = decode(hDec, y');
receivedBits = +receivedBits;
% Iterates on LLR, outputs binary 1,0


errorAmount = nnz(receivedBits - encodedData);
error_ratio = errorAmount/64800;


end