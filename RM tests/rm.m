%Function: rm(r,m) generates a Reed Muller matrix

function [G,d] = rm(r,m)

G = fliplr(reedMuller(r,m));
d = 2^(m-r); %This is the minimum distance

end
