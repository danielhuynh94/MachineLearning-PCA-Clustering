function X = getYaleFacesData()
    files = dir('yalefaces');
    X = single(zeros(154, 1600));

    %Read the files
    for k=1:length(files)
       name = files(k).name;
       if (startsWith(name, 'subject'))
          %Read in the image as a 2D array (234x320 pixels)
          img = imread(strcat('yalefaces/', name));
          %Subsample the image to become a 40x40 pixel image(for processing
          %speed)
          resizedImage = imresize(img, [40 40]);
          %Flatten the image to 1D array (1x1600)
          reshapedImage = reshape(resizedImage, [1, 1600]);
          %Concatenate this as a row of your data matrix
          X(k-2,:) = reshapedImage;
       end
    end
end