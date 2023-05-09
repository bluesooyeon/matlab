
x=[2 3 5 6 8 9]'; t=[0 0 1 1 0 0]'; rand('seed',50);
b=rand(1); w=rand(1); 
eta = 0.1; max_iter = 1.0e6; Tol = 10^(-9); Res = 2*Tol;

u = w*x + b;
p = inline('1./(1+exp(-uu))','uu');
Dp = inline('exp(-uu)./(1+exp(-uu)).^2','uu');
y=p(u); 

f = inline('sum(0.5*(y-t).^2)/6','y','t');
E1 = f(y,t);

fprintf('y(1) = (%f, %f, %f, %f, %f,%f), f(y,t)=%f \n', y, f (y, t));

n=1;
while  Res >= Tol && n <= max_iter         
    for i=1:length(x)
        u(i)= w*x(i) + b;
        y(i)=p(u(i));
        df_b = (y(i)-t(i))*Dp(u(i));
        df_w = (y(i)-t(i))*Dp(u(i))*x(i);  
        b = b - eta*df_b;
        w = w - eta*df_w;        
    end    
    u = b + w*x;
    y = p(u);
    E2 = f(y,t);
    Res = abs(E2-E1);
    E1 = E2;
    n=n+1;
    if mod(n,100)==0
        fprintf('y(%d) = (%f, %f, %f, %f, %f,%f), f(y,t)=%f \n', n, y, f (y, t));
    end   
end
fprintf('y(%d) = (%f, %f, %f, %f, %f, %f), f(y,t)=%f \n', n, y, f (y, t));
E2
Res
w
b

%%%
% x=[2 3 5 6 8 9]'; t=[0 0 1 1 0 0]';
% plot(x,t,'r*')
%
%%% Use sigmoid.m
%%% minimizer y = w* x + b with w = -0.1096, b = -0.4860
% hold on
% xx=1:0.05:10; 
% plot(xx,sigmoid(w*xx+b),'b-','Linewidth',1.5);
%
% plot(xx,0.5*ones(size(xx)),'k-','Linewidth',1.5);