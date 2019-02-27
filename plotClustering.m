function figure = plotClustering(data, observationsReferenceVectors, referenceVectors, k, iteration)
    colors = 'ymcrgbk';
    % If the data has only 2 features, 2D plot
    if size(data,2) == 2
        for i=1:k
            scatter(referenceVectors(i,1), referenceVectors(i,2), 90, colors(i), 'filled');
            hold on
        end
        gscatter(data(:,1), data(:,2), observationsReferenceVectors, colors, 'x');
    else
        % If the data has 3 features, 3D plot
        for i=1:k
            scatter3(data(observationsReferenceVectors==i,1), data(observationsReferenceVectors==i,2), data(observationsReferenceVectors==i,3), 90, colors(i), 'x');
            hold on;
            scatter3(referenceVectors(i,1), referenceVectors(i,2), referenceVectors(i,3), 90, colors(i), 'filled');
        end
    end
    title(strcat('Iteration', num2str(iteration)));
    hold off;
    figure = gcf;
end