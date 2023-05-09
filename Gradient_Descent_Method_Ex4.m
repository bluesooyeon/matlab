
N = 10; x = 0.5*ones(N,1); eta=0.7;

f = inline('0.5 * sum ( (x - transpose([1:N])/N).^2 ) ', 'x', 'N');
partial_der_f = inline(' x - t ', 'x', 't');

fprintf('x(1) = (%f, %f, %f, %f, %f, %f, %f, %f, %f, %f), f(x(1))=%f \n', x, f (x, N));
new_x = zeros(N,1); % Preallocation for a new parameter 'new_x'
for k=1:10
    for i=1:10   
        new_x(i) = x(i)-eta*partial_der_f(x(i), i/N);    
    end    
    x = new_x;
    fprintf('x(%d) = (%f, %f, %f, %f, %f, %f, %f, %f, %f, %f), f(x(%d))=%f \n', k+1, x, k+1, f (x, N));
end

