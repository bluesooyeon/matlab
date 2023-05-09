%%% learning_book.m %%%
clear;
% fileID = fopen('trainimages.bin');
% X = fread(fileID,[60000 784])/255;
% fclose(fileID);
% fileID = fopen('trainlabels.bin');
% T = fread(fileID)

% fclose(fileID);
data=load('mnist_train.csv');
T=data(:,1); % label
X=data(:,2:end)/255; % data point

index = [0 1 2 3 4 5 6 7 8 9];
description = ["T-shirt/Top" "Trouser" "Pullover" "Dress" "Coat" "Sandals" "Shirt" "Sneaker" "Bag" "Ankle boots"];
d = dictionary(index,description);

T(T==0)=10;
input_node  = 28*28;
hidden_node = 30;
output_node = 10;
rand('seed',10);
w = 0.1*(2*rand(hidden_node, input_node+1)-1);
v = 0.1*(2*rand(output_node, hidden_node+1)-1);
eta=0.1; MaxIter=100;Iter=1;
Tol=1.0e-10; Difference = Tol*2;
E1=0;
for m=1:length(T)
    xl=[1 X(m,:)]';    
    uh=w*xl;    
    z=sigmoid(uh);   
    z=[1;z];   
    uo=v*z;  
    y=sigmoid(uo);   
    t(1:output_node,1)=0;
    t(T(m))=1;
    E1=E1+sum(0.5*(y-t).^2); % E1=E1+sum((y-t).^2);
end
E1=E1/length(T);
fprintf('%i-th update and error is %f\n ', Iter-1, E1);
while Difference>=Tol && Iter<=MaxIter
    for m=1:length(T)
        xm=[1 X(m,:)]';
        uh=w*xm;
        z=sigmoid(uh); % size of z is 30 x 1
        z=[1;z]; % size of z is 31 x 1
        uo=v*z;
        y=sigmoid(uo);
        t(1:output_node,1)=0;
        t(T(m))=1;
        del_k=d_sigmoid(uo).*(y-t); % size of del_k is 10 x 1
        dEdv=del_k*z'; % size of dEdv is 10 x 31
        del_j=d_sigmoid(uh).*(v(:,2:end)'*del_k); % size of del_j is 30 x 1    
        dEdw=del_j*xm'; % size of dEdw is 30 x 785     
        v=v-eta*dEdv;
        w=w-eta*dEdw;
    end
    E2=0;
    for m=1:length(T)
        xl=[1 X(m,:)]';
        uh=w*xl;
        z=sigmoid(uh);
        z=[1;z];
        uo=v*z;
        y=sigmoid(uo);
        t(1:output_node,1)=0;
        t(T(m))=1;
        E2=E2+sum(0.5*(y-t).^2); % E2=E2+sum((y-t).^2);
    end
    E2=E2/length(T);
    Difference = abs(E2-E1);
    E1 = E2;
    fprintf('%i-th update and error is %f\n ',Iter, E1);
    Iter=Iter+1;
end
fprintf('The learning is finished \n');
save 'learningdata.mat'