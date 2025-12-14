function error = onebitlinear_repe(n,m,repe)
errl = zeros(1,repe);
for i = 1:repe
    errl(i) = onebitlinear(n,m);
end
error = mean(errl);
end
