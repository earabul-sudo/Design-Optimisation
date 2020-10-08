cleanedinputs = [cleanedData(:,1),cleanedData(:,2),cleanedData(:,3),cleanedData(:,4),cleanedData(:,5)];
cleanedoutputs = cleanedData(:,6);

%standardisation
for i = 1: size(cleanedinputs,2)
standardisedinputs(:,i) = (cleanedinputs(:,i)-mean(cleanedinputs(:,i)))/(std(cleanedinputs(:,i)));
end

for i = 1: size(cleanedoutputs,2)
standardisedoutputs(:,i) = (cleanedoutputs(:,i)-mean(cleanedoutputs(:,i)))/(std(cleanedoutputs(:,i)));
end

scaledstandardisedinputs = rescale(standardisedinputs);
scaledstandardisedoutputs = rescale(standardisedoutputs);


%coefficient of determination

mdl = fitlm(scaledstandardisedinputs,scaledstandardisedoutputs)
beta = mdl.Coefficients(2:end,1)
beta = table2array(beta)

% A = rank(scaledstandardisedinputs);
% invinputs = pinv((scaledstandardisedinputs));
% beta = invinputs * scaledstandardisedoutputs;

plot(mdl)