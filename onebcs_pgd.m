function [error,errl,x,xhat] = onebcs_pgd(n,m,act_k, k,eta,T)
%% suppose that x is normalized
%% data generation
errl = zeros(1,T+1);
x = randn(n,1); 
xx = randsample(n,n-act_k);
x(xx) = 0; % let support be uniformly distributed
x = x/norm(x); 

A = randn(m,n);
y = sign(A*x);

%% for iteration 
xhatt = zeros(n,1);
xhat = A' * y;
[~,suppx] = maxk(abs(xhat),k);
xhatt(suppx) = xhat(suppx); 
xhat = xhatt;
xhat = xhat / norm(xhat);

%% LOOP
for i = 1:T
    vec_m = (sign(A*xhat)-y)/2;
    vec_m = vec_m .* A;
    grad = mean(vec_m)';
    xhat = xhat - eta * grad; 
    %% the additional truncation step
    [~,suppx] = maxk(abs(xhat),k);
    xhatt(suppx) = xhat(suppx); 
    xhat = xhatt;
    xhatt = zeros(n,1);
    %% normalization
    xhat = xhat / norm(xhat); 
    errl(i+1) =  norm(xhat - x);
end
error = errl(T+1);
end

