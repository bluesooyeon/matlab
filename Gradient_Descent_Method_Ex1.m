function Gradient_Descent_Method_Ex1(x0,max_iter,eta)

f = @(x) 3*(x-2).^2+5;
der_f = @(x) 6*(x-2);

x(1)=x0;
res = inf;
i=1;
while i < max_iter && res > 10^(-8)   
    x(i+1) = x(i)-eta*der_f(x(i));
    res = abs(x(i+1)-x(i));
    i=i+1;
end
fprintf (1,'After %d iterations, the global min of f is %f at the point %f \n\n', i, f(x(end)), x(end));
% sol = x(end);