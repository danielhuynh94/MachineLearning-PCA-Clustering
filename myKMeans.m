function [referenceVectors, observationsReferenceVectors] = myKMeans(X, k)

    if size(X,1) < k
        return
    end

    if size(X,2) > 3
        % If the data has more than 3 features, apply PCA to reduce the dimension to 3D
        [projectedMatrix, sortedEigenVectors, sortedEigenValues] = myPCA(X);
        data = projectedMatrix(:,1:3);
    else
        data = X;
    end
    dataSize = size(data);
    
    % Get the first k randomized indices to select initial reference
    % vectors
    kRandomizedIndices = randperm(dataSize(1,1), k);
    referenceVectors = data(kRandomizedIndices(:), :);

    % This variable holds the index of the associated reference vectors for the
    % observations
    observationsReferenceVectors = zeros(dataSize(1, 1), 1);

    % Plot the initial setup visualization
    colors = 'ymcrgbk';
    if size(data,2) == 2
        scatter(data(:,1), data(:,2), 'x');
        hold on;
        for i=1:k
            scatter(referenceVectors(i,1), referenceVectors(i,2), 90, colors(i), 'filled');
        end
    else
        % If the data has 3 features, 3D plot
        scatter3(data(:,1), data(:,2), data(:,3), 'x');
        hold on;
        for i=1:k
            scatter3(referenceVectors(i,1), referenceVectors(i,2), referenceVectors(i,3), 90, colors(i), 'filled');
        end
    end
    title('Initial setup');
    frames(1) = getframe(gcf);
    
    change = 1;
    iteration = 0;
    % If the sum of the magnitude of change of cluster centers is less than
    % eps, return
    while change > eps('single')
        iteration = iteration + 1;
        
        % Calculate the distance between each observation data point to the
        % first reference vector
        for i=1:dataSize(1,1)
            referenceVectorIndex = 0;
            minDistance = 0;
            for j=1:size(referenceVectors, 1)
                distance = sum((data(i,:) - referenceVectors(j,:)) .^ 2);
                if j == 1 || distance < minDistance
                    minDistance = distance;
                    referenceVectorIndex = j;
                end
            end
            observationsReferenceVectors(i) = referenceVectorIndex;
        end

        % Plot the clustering
        figure();
        f = plotClustering(data, observationsReferenceVectors, referenceVectors, k, iteration);
        drawnow;
        frames(iteration+1) = getframe(f);
        

        % Recompute the reference vectors
        prevReferenceVectors = referenceVectors;
        for i=1:k
            referenceVectors(i, :) = mean(data(observationsReferenceVectors==i,:));
        end

        % Compute the sum of magnitude of change of the cluster centers
        change = sum(sum(abs(referenceVectors - prevReferenceVectors)));
    end
    
    % Generate the videos from the figures
    videoWriter = VideoWriter(strcat('K_', num2str(k), '.avi'));
    videoWriter.FrameRate = 0.9;
    open(videoWriter);
    for i=1:length(frames)
        writeVideo(videoWriter, frames(i));
    end
    close(videoWriter)
end
