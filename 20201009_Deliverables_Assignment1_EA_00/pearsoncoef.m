%Calculate Pearson Coefficiencts for cleaned data
pearsoncoeff1 = corrcoef(cleanedData(:,1),cleanedData(:,6))
pearsoncoeff2 = corrcoef(cleanedData(:,2),cleanedData(:,6))
pearsoncoeff3 = corrcoef(cleanedData(:,3),cleanedData(:,6))
pearsoncoeff4 = corrcoef(cleanedData(:,4),cleanedData(:,6))
pearsoncoeff5 = corrcoef(cleanedData(:,5),cleanedData(:,6))

%Create plots for each dataset
figure(1)
scatter(cleanedData(:,1),cleanedData(:,6))
figure(2)
scatter(cleanedData(:,2),cleanedData(:,6))
figure(3)
scatter(cleanedData(:,3),cleanedData(:,6))
figure(4)
scatter(cleanedData(:,4),cleanedData(:,6))
figure(5)
scatter(cleanedData(:,5),cleanedData(:,6))