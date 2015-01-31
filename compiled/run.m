function run
% Script to submit jobs to the queuing system

for EbNo = 0:0.5:6
    system(['qsub -t 1-100:1 -b y -j y -cwd -o /dev/null ber_sim ' num2str(EbNo) ' results' num2str(EbNo) '.dat']);
end

end