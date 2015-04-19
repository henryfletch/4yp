function I = import_data_2(valueRange,textMask)

I = [];

for i = valueRange
    display(i);
    value = strcat(num2str(i),textMask,'_*');
    d = dir(value);
    names = {d.name};
    L = length(names);
    R = zeros(1,L);
    parfor j = 1:L
    tempID = fopen(names{j});
    string = textscan(tempID,'%s');
    fclose(tempID);
    [~,BERstring] = strtok(string,',');
    BERstring2 = BERstring{1,1}{1,1};
    R(j) = str2double(BERstring2(9:end));
    end
    [m,n] = size(R);
    errRatio = sum(R(:))/(m*n);
    I = [I;i,errRatio,m*n];
end


    