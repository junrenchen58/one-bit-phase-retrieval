function error = SPGD_albe_repe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed,repe)
errl = zeros(1,repe);
for i = 1:repe
    errl(i) = SPGD_albe(n,m,act_k,k,alpha,beta,tau,etamode,T,seed);
end
error = mean(errl);
end

