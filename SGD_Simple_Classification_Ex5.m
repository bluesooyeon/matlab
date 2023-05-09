
x=[-2 -1 0 1 2]'; t=[0 0 1 1 1]'; rand('seed',50);
b=rand(1); w=rand(1); 
eta = 0.1; max_iter = 1.0e6; 
Tol = 10^(-5); % Compared with Tol = 10^(-8);
Res = 2*Tol;

u = w*x + b;
p = inline('1./(1+exp(-uu))','uu');
Dp = inline('exp(-uu)./(1+exp(-uu)).^2','uu');
y=p(u);

f = inline('sum(0.5*(y-t).^2)/5','y','t');
E1 = f(y,t);

fprintf('y(1) = (%f, %f, %f, %f, %f), f(y,t)=%f \n', y(1),y(2),y(3),y(4),y(5), f (p(u), t)); % y=p(u)

% new_x = zeros(length(x),1); % Preallocation for a new parameter 'new_x'
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
        fprintf('y(%d) = (%f, %f, %f, %f, %f), f(y,t)=%f \n', n, y(1),y(2),y(3),y(4),y(5), f (y, t));
    end   
end
fprintf('y(%d) = (%f, %f, %f, %f, %f), f(y,t)=%f \n', n, y, f (p(u), t));
w
b


x=[-2 -1 0 1 2]'; t=[0 0 1 1 1]';
plot(x,t,'r*')

%%% Use sigmoid.m 
%%% Minimizer y = w * x + b i.e., w = 3.1555, b = 1.4356
hold on
xx=-3:0.05:3; 
plot(xx,sigmoid(w*xx+b),'b-','Linewidth',1.5);
plot(xx,0.5*ones(size(xx)),'k-','Linewidth',1.5);