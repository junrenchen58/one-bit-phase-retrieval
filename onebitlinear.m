function error = onebitlinear(n,m)

x = randn(n,1); 
x = x/norm(x); 
A = randn(m,n);
y = sign(A*x);

f = zeros(n,1);
AA = -diag(y)*A;
A = [AA;-(1/m)*y'*A];
b = zeros(m+1,0);
b(m+1) = -1;
xhat = linprog(f,A,b);
xhat = xhat/norm(xhat);
error = norm(xhat - x);

end

