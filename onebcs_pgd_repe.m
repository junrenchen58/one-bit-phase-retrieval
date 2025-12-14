function error = onebcs_pgd_repe(n,m,act_k,k,eta,T,repe)
errl = zeros(1,repe);
for i = 1:repe
    errl(i) = onebcs_pgd(n,m,act_k,k,eta,T);
end
error = mean(errl);
end

