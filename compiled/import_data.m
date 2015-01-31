function I = import_data(EbNoRange)

I = [];

for i = EbNoRange
    R = [];
    display(i);
    value = strcat('results', num2str(i),'_*');
    d = dir(value);
    names = {d.name};
    L = length(names);
    parfor j = 1:L
    R(:,j) = importdata(names{j});
    end
    [m,n] = size(R);
    errRatio = sum(R(:))/(m*n);
    I = [I;i,errRatio,m*n];
end


    