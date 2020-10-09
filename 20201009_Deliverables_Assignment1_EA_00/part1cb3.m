clear all
%Size of the supposed matrix
sizek = [500 5];
N = sizek(1); % Sample Size
k = sizek(2); %Number of parameters

%calculating sobol numbers

Pseudo_Rand = sobolset(2*k);
A = Pseudo_Rand(2:N+1, 1:k);
B = Pseudo_Rand(2:N+1, k+1:end);
ABi = cell(1,k);

for k = 1:k
    ABi{k} = A;
    ABi{k}(:,k) = B(:,k);
end
% A =mat2cell(A,(size(A,1)),size(A,2))     
% B =mat2cell(B,(size(B,1)),size(B,2))
% A_B = repmat(A, [k,1]);
% for i = 1:k
%     A_B((i-1)*N + 1: i*N, i) = B(:,i);
% end


%please change the model number in TurbineModel_2020 funtion to get
%different sets of results for models
%calculating outputs sobol sets
for k = 1:k
    for N =1:N
        
        Aout{k}(N) = TurbineModel_2020(A(N,:),'1',1);
        Bout{k}(N) = TurbineModel_2020(B(N,:),'1',1);
        A_Biout{k}(N) = TurbineModel_2020(ABi{k}(N,:),'1',1);
        
        %First order Indices
        
        Vxi{k}(N) = (1/N) * Bout{k}(N) * (A_Biout{k}(N) - Aout{k}(N))^2;
        
        %Total Order Indices
        
        Exi{k}(N) = (1/2*N) * ( Aout{k}(N) - A_Biout{k}(N) )^2;
        
        
       
        
    end
    
        totalvar(k) = var(Vxi{k}) + var(Exi{k});
        Si{k} = Vxi{k}/ totalvar(k);
        Sifinal(k) = mean(cell2mat(Si));
        
        Sti{k} = Exi{k}/totalvar(k);
        Stifinal(k) = mean(cell2mat(Sti));
end

%Variance Set

disp(Sifinal);
disp(Stifinal);