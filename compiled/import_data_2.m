function I = import_data_2

I = [];

for i = 0:0.5:7
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


    