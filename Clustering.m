close all;

% Get the Yale Faces data
X = getYaleFacesData();

% Calculate the means and the standard deviations of the matrix
% Standardize the matrix
standardizedData = getStandardizedData(X);

% Apply k means
k = 5;
[referenceVectors, observationsReferenceVectors] = myKMeans(standardizedData, k);