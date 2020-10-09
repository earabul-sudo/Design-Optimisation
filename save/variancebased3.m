% Get Size of inputs
sizek  = size(scaledstandardisedinputs);
N = sizek(1);
k = sizek(2);


% Create a set of quasirandom numbers using the Sobol scheme that has 2*k columns
Pseudo_Rand = sobolset(2*k);
A = Pseudo_Rand(2:N+1, 1:k);
B = Pseudo_Rand(2:N+1, k+1:end);
A_B = repmat(A, [k,1]);
% Create A_B 
for i = 1:k
            A_B((i-1)*N + 1: i*N, i) = B(:,i);
end
A_B = A_B(1:size(N),:);

%For each parameter, calculate Aout,Bout and A_Bout use them as input for 
%Vxi and Exi

for i= 1:k
Aout(:,i) = A(:,i) * beta(i);
Bout(:,i) = B(:,i)* beta(i);
A_Bout(:,i) = A_B(:,i) * beta(i);
Vxi(:,i) = (1/N) * Bout(:,i) .* (A_Bout(:,i) - Aout(:,i));
Exi(:,i) = (1/2*N) * ( Aout(:,i) - A_Bout(:,i) ).^2;

end

%Get mean Value for Vxi and Exi

Vxitotal = mean(Vxi,1);
Exitotal = mean(Exi,1);

%Calculate Si, Sti

Si = Vxitotal/var(scaledstandardisedoutputs)
Sti = Exitotal/var(scaledstandardisedoutputs)



