% Prints to screen the error correction capability of a given minimum
% distance

function printCapability(d)

detectedErrors = d-1;
correctableErrors = detectedErrors/2;

fprintf('Detectable Errors = %d\n',detectedErrors);
fprintf('Min. Correctable Errors = %d\n',floor(correctableErrors));

end