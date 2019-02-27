function standardizedData = getStandardizedData(X)
    standardizedData = (X - mean(X)) ./ std(X);
end