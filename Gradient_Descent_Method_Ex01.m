
x_ini = input('initial guess x_ini =  ');
eta = input(' eta = ');

f = @(x) 3*(x-2).^2+5;
der_f = @(x) 6*(x-2);

x(1)=x_ini;
fprintf('x(1) = %f, f(x(1)) = %f \n', x(1), f(x(1)));

for i=1:10
    x(i+1) = x(i)-eta*der_f(x(i));
    fprintf('x(%d) = %f, f(x(%d)) = %f \n',i+1,x(i+1), i+1, f(x(i+1)));    
    pause;
end
    


% % function Gradient_Descent_Method_Ex1(x0,max_iter,eta)
% % 
% % f = @(x) 3*(x-2).^2+5;
% % der_f = @(x) 6*(x-2);
% % 
% % x(1)=x0;
% % res = inf;
% % i=1;
% % while i < max_iter && res > 10^(-8)   
% %     x(i+1) = x(i)-eta*der_f(x(i));
% %     res = abs(x(i+1)-x(i));
% %     i=i+1;
% % end
% % fprintf (1,'After %d iterations, the global min of f is %f at the point %f \n\n', i, f(x(end)), x(end));
% % % sol = x(end);