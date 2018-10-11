%function number_of_pixels = FindCubeSatPixels(b,imageName,I_binarized,...
function [] = FindCubeSatPixels(b,imageName,I_binarized,...
    plotBinarized)
    %%%%% Crop binarized image to the region containing the cube, allowing
    %%%%% for accurate pixel count (binary pixels == 1)
    boundaryXStart = min(b(:,2));
    boundaryXEnd = max (b(:,2));
    boundaryYStart = min(b(:,1));
    boundaryYEnd = max(b(:,2));
    
    %image_cropped = imcrop(I_binarized,[boundaryXStart,boundaryYStart,...
        %boundaryXEnd-boundaryXStart,boundaryYEnd-boundaryYStart]);
    %number_of_pixels = length(find(image_cropped==1));
    
    if plotBinarized == 1
        figure
        imshow(I_binarized,'InitialMagnification','fit');
        title({['Image Number: ' , imageName] , ...
            ['Number of Pixels: ']});%,num2str(number_of_pixels)]})
        saveas(gcf,['BinarizedImageOutputs/','binarized_',imageName]);
    end
end