clf;

% Get the Yale Faces data
X = getYaleFacesData();

% Calculate the means and the standard deviations of the matrix
% Standardize the matrix
standardizedData = getStandardizedData(X);

% Apply PCA
[projectedMatrix, sortedEigenVectors, sortedEigenValues] = myPCA(standardizedData);

% Graph the principle component as a 40x40 image
subplot(1,4,1), imshow(reshape(mat2gray(1 - sortedEigenVectors(:,1)), [40, 40]));
title('Visualization of PPC')

% Graph the original image
subplot(1,4,2), imshow(reshape(mat2gray(X(1,:)), [40, 40]));
title('Original Image')

% Reconstruct the first person using the primary principle component; then,
% graph it
reconstructedWithPPC = projectedMatrix(1,1) * sortedEigenVectors(:,1)';
% Unstandardize the vector
reconstructedWithPPC = (reconstructedWithPPC .* std(X)) + mean(X);
subplot(1,4,3), imshow(reshape(mat2gray(reconstructedWithPPC), [40, 40]));
title('First Person using PPC')

% Determine the k value that encode at least 95% of the information
k = 0;
variance = 0;
totalVariance = sum(sortedEigenValues);
valSize = size(sortedEigenValues);
valLength = valSize(1,1);
while k < valLength && variance <= 0.95
    k = k + 1;
    variance = variance + (sortedEigenValues(k, 1)/totalVariance);
end

% Reconstruct the first person using the k most significant eigen-vectors;
% then, graph it
kVecs = sortedEigenVectors(:,1:k);
reconstructedWithK = projectedMatrix(1,1:k) * kVecs';
% Unstandardize the vector
reconstructedWithK = (reconstructedWithK .* std(X)) + mean(X);
subplot(1,4,4), imshow(reshape(mat2gray(reconstructedWithK), [40, 40]));
title('First Person using k PC')
