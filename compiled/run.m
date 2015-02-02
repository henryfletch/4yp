function run
% Script to submit jobs to the queuing system

for EbNo = 8
    S = num2str(EbNo*10);
    S(S=='.') = [];
    system(['qsub -t 1-10000:1 -b y -j y -o /dev/null -cwd ber_sim ' num2str(EbNo) ' results' S]);
end

end
