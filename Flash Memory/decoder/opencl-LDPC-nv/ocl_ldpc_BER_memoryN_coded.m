% Function: Takes input vector x, encodes using G, performs AWGN with Sigma2,
% and then decodes using Belief Propogation (iterations l),
% finally displays BER.

function error_ratio = ocl_ldpc_BER_memoryN_coded(Rc,Nc,G,hDec,hError,SystemParams,voltageHardDecision,H,l)

% Input vector
dataIn = randi([0,1],1,Nc*Rc,'gpuArray');

%Encode block
%encodedData = step(hEnc,dataIn);
encodedData = mod(dataIn*G,2);

%Convert to a cell voltage level
y = memoryGetVoltage(encodedData,SystemParams);

% HARD DECISION process on Cell Voltage
% > vHardDecision, then binary 1 (LLR -50), otherwise binary 0 (LLR +50)
%y(y <= voltageHardDecision) = 50;
%y(y < 50) = -50; 

% SOFT DECISION -> Generate a LLR using gaussian approximation
% L is the vector of log liklehood ratios
% [mu_d,sigma_d] = getRetentionParams(SystemParams.N,SystemParams.tSecs,SystemParams.Vp,SystemParams.Verased);
% total_mu = ((2*SystemParams.Vp+SystemParams.deltaVp)/2) + mu_d;
% total_sigma2 = ((SystemParams.deltaVp^2)/12) + sigma_d^2;
% L = llr(y,SystemParams.Verased,0.35,total_mu,sqrt(total_sigma2)); %Moving gaussian
%L = llr(y,SystemParams.Verased,0.35,SystemParams.Vp,0.2); %Gaussian
L = llr_full(y,SystemParams.Verased,0.35,SystemParams); % Full function

% Belief Propogation Stage: MATLAB decoder
%receivedBits = step(hDec, L);
%receivedBits = +receivedBits;
% Iterates on LLR, outputs binary 1,0

% Belief Propogation Stage: My decoder
%receivedLLR = BP_iterate(L',H,l);
%receivedBits(receivedLLR > 0) = 0;
%receivedBits(receivedLLR < 0) = 1;
%receivedBits = receivedBits';

% OpenCL Decoder
L = gather(L);
[~, receivedBits] = hDec.decode(L, l);

encoded = gather(encodedData);
errorStats = step(hError, encoded', +receivedBits');
error_ratio = errorStats(1);


end