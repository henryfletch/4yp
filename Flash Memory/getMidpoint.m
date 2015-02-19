function midpoint = getMidpoint(numberP,edgesP,numberE,edgesE)

lengthP = length(edgesP);
lengthE = length(edgesE);

areaP = 0;
areaE = 1;

% Decision values:
vDecision = 2.0;
deltaV = 0.005;

while areaP < areaE

% P: Find corresponding i for given Voltage
iStartP = find(edgesP < vDecision);

% Area of Programmed
deltaP = 0;
for i = iStartP
deltaP(i) = (edgesP(i+1)-edgesP(i))*numberP(i);
end
areaP = sum(deltaP);

% E: Find corresponding i for Given Voltage
iStartE = find(edgesE > vDecision);

% Area of Erased
deltaE = 0;
for i = iStartE
    deltaE(i) = (edgesE(i) - edgesE(i-1))*numberE(i-1);
end
areaE = sum(deltaE);

midpoint = vDecision;
vDecision = vDecision + deltaV;
end