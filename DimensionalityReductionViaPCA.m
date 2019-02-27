clf;

% Get the Yale Faces data
X = getYaleFacesData();

% Calculate the means and the standard deviations of the matrix
% Standardize the matrix
standardizedData = getStandardizedData(X);

% Apply PCA
[projectedMatrix, eigenVectors, eigenValues] = myPCA(standardizedData);

% Plot the data
plot(projectedMatrix(:,1), projectedMatrix(:,2), 'o');

