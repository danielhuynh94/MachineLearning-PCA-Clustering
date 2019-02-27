function [projectedMatrix, sortedEigenVectors, sortedEigenValues] = myPCA(standardizedMatrix)
    
    % Find the covariance matrix
    covarianceMatrix = cov(standardizedMatrix);
    
    % Find the eigenvalues and eigenvectors
    [vec, val] = eig(covarianceMatrix);
    
    % Sort the eigenvalues and eigenvectors in descending order to find the
    % significant one
    [sortedEigenValues, ind] = sort(diag(val), 'descend');
    sortedEigenVectors = vec(:,ind);
    
    % Project the standardized data
    projectedMatrix = standardizedMatrix * sortedEigenVectors;

end