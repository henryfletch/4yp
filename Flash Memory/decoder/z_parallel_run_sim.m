function z_parallel_run_sim

warning('off','all');
parpool(8);
display('Parpool created, running...');

parfor i = 1:10000000000000000
    run_sim(35000,'movingGaussianTwo35000');
end

end