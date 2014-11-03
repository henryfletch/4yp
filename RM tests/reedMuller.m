%input: reedMuller(r,m)
%output: G {generator matrix}

function G = reedMuller(r,m)

%%%%Recursion to create G: 
%%%%REF: [PDF2] page 5

%G(0,0) case:
if m == 0 && r == 0
    G = [1 1];
    return
end

%G(1,1) case:
if m == 1 && r == 1
    G = [1 1;0 1];
    return
end

%G(m,m) r=m case:
if m == r
    G = [reedMuller(m-1,m); zeroOneFunc(m)];
    return
end

%G(0,m) case, returns vector of all ones:
if r == 0
    G(1:2^m) = 1;
    return
end

%Finally, the equation:
%'mem' is same operation done twice, to avoid too many calls,
% & some zero-padding is needed hence multiple operations:

mem = reedMuller(r,m-1);
G_upper = [mem, mem];
G_lower = reedMuller(r-1,m-1);
n = size(G_lower);

G = [G_upper; zeros(n),G_lower];

end

