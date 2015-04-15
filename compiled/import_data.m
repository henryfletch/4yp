function I = import_data(valueRange,textMask)
% valueRange is a vector of 10x EbNo values to read from(50 = 5dB)
% TextMask is just the bit before, e.g. 'mem_gaussian'
% The files should look something like:
% mem_gaussian50_abd08u4_534581_4234.txt
% The program assumes textMask is first in the filename and the EbNo value
% 2nd

I = [];

for i = valueRange
    display(i);
    value = strcat(textMask, num2str(i),'_*'); %Construct the filename to search for
    d = dir(value); %list all items in the directory which are called 'value'
    names = {d.name}; % & get the exact file paths to these files
    L = length(names); %The number of text files to read
    R = zeros(1,L); 
    parfor j = 1:L % Parfor loop: Much quicker if 10000's of files, slower if only a few (replace with for)
    R(j) = importdata(names{j}); %Where R(j) is the BER of each text file
    end
    [m,n] = size(R);
    errRatio = sum(R(:))/(m*n); %Sum BER and average
    I = [I;i,errRatio,m*n*1000]; %< saves output as EbNo,BER,numBlocks
end


    