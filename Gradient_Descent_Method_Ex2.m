
f = inline('3*(x-2).^2+2*(y-3).^2+3','x','y');
der_x_f = inline('6*(x-2)','x','y');
der_y_f = inline('4*(y-3)','x','y');

x(1,1) = input(' x_ini in initial guess (x_ini, y_ini) =  ');
x(2,1) = input(' y_ini in initial guess (x_ini, y_ini) =  ');
eta = input(' eta = ');

fprintf('(x(1),y(1)) = (%f,%f), f(x(1),y(1)) = %f \n', x(1,1), x(2,1),f(x(1,1),x(2,1)));

for i=1:10   
    x(1,i+1) = x(1,i)-eta*der_x_f(x(1,i),x(2,i));
    x(2,i+1) = x(2,i)-eta*der_y_f(x(1,i),x(2,i));
    
    fprintf('(x(%d),y(%d)) = (%f,%f), f(x(%d),y(%d)) = %f \n', i+1,i+1, x(1,i+1), x(2,i+1),i+1,i+1,f(x(1,i+1),x(2,i+1)));   
end


% % function Gradient_Descent_Method_Ex2(x0,max_iter,eta)
% % 
% % f = @(x,y) 3*(x-2).^2+2*(y-3).^2+3;
% % der_x_f = @(x,y) 6*(x-2);
% % der_y_f = @(x,y) 4*(y-3);
% % % Grad_f = @(x,y) [der_x_f; der_y_f];
% % 
% % x(:,1)=x0;
% % res = inf;
% % i=1;
% % while i < max_iter && res > 10^(-8)   
% %     x(1,i+1) = x(1,i)-eta*der_x_f(x(1,i),x(2,i));
% %     x(2,i+1) = x(2,i)-eta*der_y_f(x(1,i),x(2,i));
% %     res = norm(x(:,i+1)-x(:,i));
% %     i=i+1;
% % end
% % fprintf (1,'After %d iterations, the global min of f is %f at the point (%f,%f) \n\n', i, f(x(1,end),x(2,end)), x(1, end),x(2,end));
% % % sol = x(:,end)
% % % f(x(1,end),x(2,end))