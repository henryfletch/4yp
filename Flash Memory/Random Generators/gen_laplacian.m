function y = gen_laplacian(b,samples)

U = gen_uniform(-0.5,0.5,samples); %Uniform generator

y = -b.*sign(U).*log(1-2.*abs(U));

end