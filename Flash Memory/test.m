%test script

clear
close

x = -5:0.0001:5;
nVector = [1,10,100,1000,10000,100000];
VpVector = [2.6,3.2,3.93];

for Vp = VpVector
    for N = nVector
        
        deltaVp = 0.25;
               
        yProgrammed = mem_programState(x,Vp,deltaVp);
        yRTN = mem_RTN(x,N);
        
        output = conv(yProgrammed,yRTN,'same');
        %output = output/norm(output);
        
        area = trapz(x,output);
        output = output/area;
        
        plot(x,output)
        hold on
        axis([0 5 0 10])
        
    end
end