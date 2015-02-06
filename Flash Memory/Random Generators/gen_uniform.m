function y = gen_uniform(a,b,samples)
%UNIFORM generates a random value taken from the uniform distribution [a,b]

%y = random('Uniform',a,b,samples,1);
u = rand(1,samples);
y = a + (b-a)*u;

end

