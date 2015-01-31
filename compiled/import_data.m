function I = import_data(EbNoRange)

I = [];

for i = EbNoRange
    display(i);
    value = strcat('results', num2str(i),'_*');
    d = dir(value);
    names = {d.name};
    L = length(names);
    R = zeros(1,L);
    for j = 1:L
    R(j) = importdata(names{j});
    end
    [m,n] = size(R);
    errRatio = sum(R(:))/(m*n);
    I = [I;i/10,errRatio,m*n*1000];
end


    