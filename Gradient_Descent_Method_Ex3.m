
f = inline('3*(x-2).^2 + 2*(y-3).^2 + 4*(z-1).^2 + 3','x','y', 'z');
der_x_f = inline('6*(x-2)','x','y','z');
der_y_f = inline('4*(y-3)','x','y','z');
der_z_f = inline('8*(z-1)','x','y','z');

x(1,1) = input(' x_ini in initial guess (x_ini, y_ini, z_ini) =  ');
x(2,1) = input(' y_ini in initial guess (x_ini, y_ini. z_ini) =  ');
x(3,1) = input(' z_ini in initial guess (x_ini, y_ini. z_ini) =  '); 
eta = input(' eta = ');

fprintf('(x(1),y(1),z(1)) = (%f,%f.%f), f(x(1),y(1),z(1)) = %f \n', x(1,1), x(2,1),x(3,1), f(x(1,1),x(2,1),x(3,1)));

for i=1:10   
    x(1,i+1) = x(1,i)-eta*der_x_f(x(1,i),x(2,i),x(3,i));
    x(2,i+1) = x(2,i)-eta*der_y_f(x(1,i),x(2,i),x(3,i));
    x(3,i+1) = x(3,i)-eta*der_z_f(x(1,i),x(2,i),x(3,i));
    
    fprintf('(x(%d),y(%d),z(%d)) = (%f,%f,%f), f(x(%d),y(%d),z(%d)) = %f \n', i+1,i+1,i+1, x(1,i+1), x(2,i+1), x(3,i+1), i+1,i+1,i+1, f(x(1,i+1),x(2,i+1),x(3,i+1)));   
end

