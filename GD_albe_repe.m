function error = GD_albe_repe(n,m,alpha,beta,tau,etamode,T,seed,repe)
errl = zeros(1,repe);
for i = 1:repe
    errl(i) = GD_albe(n,m,alpha,beta,tau,etamode,T,seed);
end
error = mean(errl);
end

