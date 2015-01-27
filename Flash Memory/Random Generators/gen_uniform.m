function y = gen_uniform(a,b,samples)
%UNIFORM generates a random value taken from the uniform distribution [a,b]

y = random('Uniform',a,b,samples,1);

end

