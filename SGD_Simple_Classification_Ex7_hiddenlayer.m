

X=[2 3 5 6 8 9]'; T=[0 0 1 1 0 0]'; 
w=[-4 1;6.5 -1]; v=[-1 1 1]; 
eta = 0.1; max_iter = 1.0e6; 
Tol = 10^(-8); % Tol = 10^(-10);
Res = 2*Tol; n=1;

p = inline('1./(1+exp(-uu))','uu');
Dp = inline('exp(-uu)./(1+exp(-uu)).^2','uu');
E = inline('sum(0.5*(y-t).^2)/6','y','t');

for m=1:length(T)
    x=[1;X(m)];
    uh=w*x;
    z=p(uh);
    z=[1;z];
    uo=v*z;
    y(m)=p(uo);
end
E1 = E(y,T');

while  Res >= Tol && n <= max_iter         
    for m=1:length(T)
        x=[1;X(m)];
        uh=w*x;
        z=p(uh);
        z=[1;z];
        uo=v*z;
        y(m)=p(uo);               
        dEdv=(y(m)-T(m))*Dp(uo)*z';      
        dEdw=((y(m)-T(m))*Dp(uo))*(Dp(uh).*v(2:end)')*x';        
        v=v-eta*dEdv;
        w=w-eta*dEdw;
    end
    for m=1:length(T)
        x=[1;X(m)];
        uh=w*x;
        z=p(uh);
        z=[1;z];      
        uo=v*z;
        y(m)=p(uo);
    end
    E2=E(y,T');
    Res=abs(E2-E1);
    E1=E2;
    n=n+1;
    if mod(n,100)==0
        fprintf('y(%d) = {%.6f, %.6f, %.6f, %.6f, %.6f, %.6f}\n'...
            ,n,y(1),y(2),y(3),y(4),y(5),y(6));
        fprintf('Residual = %.6f, E(W,X) =  %.6f\n',Res,E1);
    end
end
fprintf('y(%d) = {%.6f, %.6f, %.6f, %.6f, %.6f, %.6f}\n'...
    ,n,y(1),y(2),y(3),y(4),y(5),y(6));
fprintf('Residual = %.6f, E(W,X) =  %.6f\n',Res,E1);

%%%
% x=[2 3 5 6 8 9]'; t=[0 0 1 1 0 0]';
% plot(x,t,'r*')
%
%%% Use sigmoid.m
%%% z_1 =phi( w_{1,0} + w_{1,1} * x ),  z_2 = phi( w_{2,0} + w_{2,1} * x )
% hold on
% xx=1:0.05:10;
% z1=sigmoid(w(1,1)+w(1,2)*xx); z2=sigmoid(w(2,1)+w(2,2)*xx);
% plot(xx,z1,'b-','Linewidth',1.5); % plot z_1 = phi(u_1^h)
% pause;
% plot(xx,z2,'m-','Linewidth',1.5); % plot z_2 = phi(u_2^h)
% 
% pause;
% u_out = v(1,1)+v(1,2)*z1+v(1,3)*z2;
% plot(xx,u_out,'c-','Linewidth',1.5);
%
% pause;
% y=sigmoid(u_out);
% plot(xx,y,'k-','Linewidth',1.5);


