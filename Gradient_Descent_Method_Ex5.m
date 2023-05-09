
x=[-2 -1 0 1 2]'; t=[0 0 1 1 1]'; rand('seed',50);
b=rand(1); w=rand(1); 
eta = 0.1; max_iter = 1.0e6; Tol = 10^(-12); Res = 2*Tol;
y = w*x + b;
f = inline('sum(0.5*(y-t).^2)/5','y','t');
E1 = f(y,t);

fprintf('y(1) = (%f, %f, %f, %f, %f), f(y,t)=%f \n', y(1),y(2),y(3),y(4),y(5), f (y, t));

n=1;
while  Res >= Tol && n <= max_iter         
    b = b - eta*0.2*sum(y-t);
    w = w - eta*0.2*sum((y-t).*x);   
    
    y = b + w*x;
    E2 = f(y,t);
    Res = abs(E2-E1);
    E1 = E2;
    n=n+1;
    if mod(n,100)==0
        fprintf('y(%d) = (%f, %f, %f, %f, %f), f(y,t)=%f \n', n, y(1),y(2),y(3),y(4),y(5), f (y, t));
    end   
end
fprintf('y(%d) = (%f, %f, %f, %f, %f), f(y,t)=%f \n', n, y, f (y, t));
w
b

%%%
% x=[-2 -1 0 1 2]'; t=[0 0 1 1 1]';
% plot(x,t,'r*')
%
%%% Minimizer y = 0.3 * x + 0.6 i.e., w=0.3 and b=0.6
% xx=-3:0.05:3; 
% plot(xx,w*xx+b,'b-','Linewidth',1.5);
%
% plot(xx,0.5*ones(size(xx)),'k-','Linewidth',1.5);

