%Size of the Input Matrix
sizek  = size(cleanedinputs);
N = sizek(1);
k = sizek(2);
% %Firstly create an object of Sobol pseudorandom numbers with twice
% as many columns as there are input factors to your model (i.e.
% 2*k)
Quas_Rand = sobolset(2*k);
% % Use the set to create matrices of pseudorandom numbers ignoring
% the first row (please do this). N is the number of required
% samples and k

A = Quas_Rand(2:N+1, 1:k);
B = Quas_Rand(2:N+1, k+1:end);

for i =1:size(A,2)
    At=A(:,1:i-1);
    Bt=B(:,i);
    Ct=A(:,i+1:end);
    
    A_B = [At, Bt, Ct];
    A_Bdata(i) = {A_B};
end

%                  Estimate        SE        tStat       pValue  
%                    _________    ________    _______    __________
% 
%     (Intercept)      0.23786    0.032778     7.2567    2.8102e-12
%     x1               0.12228    0.066576     1.8367      0.067148
%     x2             0.0067747    0.042558    0.15919       0.87362
%     x3                 0.856    0.064613     13.248    1.8072e-32
%     x4              -0.19799    0.042988    -4.6056    5.8613e-06
%     x5              0.030022    0.037071    0.80985       0.41861

%Create Outputs for Generated Sobol Numbers

for j =2:N
    for i =1:k
        
Aeval(j,i) = (beta(1)*A(j,i)+ beta(2)*A(j,i) +beta(3)*A(j,i)+ beta(4)*A(j,i)+ beta(5)*A(j,i));
Beval(j,i) = (beta(1)*B(j,i)+ beta(2)*B(j,i) + beta(3)*B(j,i) + beta(4)*B(j,i)+ beta(5)*B(j,i));
A_Beval(j,i) = beta(1)*A_Bdata{i}(j,i)+ beta(2)*A_Bdata{i}(j,i) +beta(3)*A_Bdata{i}(j,i) + beta(4)*A_Bdata{i}(j,i)+ beta(5)*A_Bdata{i}(j,i);

%Simplified Fit
% Aeval(j,i) = 0.887599* A(j,i);
% Beval(j,i) = 0.887599* B(j,i);
% A_Beval(j,i) = 0.887599* A_B(j,i);

    end
end

%Calculate Numerator terms

for j =2:N
    for i =1:k
Vxi(j,i) = (1/N) * (Beval(j,i))*((A_Beval(j,i)) - (Aeval(j,i)));
    end
end

for j =2:N
    for i =1:k
Exi(j,i) = (1/(2*N)) * ((Aeval(j,i)) -(A_Beval(j,i)))^2;
    end
end

%Get varinace of total outputs
varoutputs = var(scaledstandardisedoutputs);

%Get First Order Effects and Total Order Effects
Si = Vxi / varoutputs;
Sti =  Exi / varoutputs;

%Calculate only one value for Si and Sti
Sifinal(:,1)= mean(Si(:,1));
Sifinal(:,2)= mean(Si(:,2));
Sifinal(:,3)= mean(Si(:,3));
Sifinal(:,4)= mean(Si(:,4));
Sifinal(:,5)= mean(Si(:,5))

Stifinal(:,1)= mean(Sti(:,1));
Stifinal(:,2)= mean(Sti(:,2));
Stifinal(:,3)= mean(Sti(:,3));
Stifinal(:,4)= mean(Sti(:,4));
Stifinal(:,5)= mean(Sti(:,5))
