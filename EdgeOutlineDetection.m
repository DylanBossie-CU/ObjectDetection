%%%%%Dylan Bossie
%%%%%10/7/2018
%%%%%VANTAGE
%%%%%PDR Object Detection Feasibility
clc
close all
clear

%set(0, 'defaultfigureposition',[0.25 0.25 0.5 0.5]);

imageFiles = dir('Images/8*');

jerry = 7360*4912;

plotGrayscale = 0;
plotBinarized = 0;

number_of_pixels = zeros(length(imageFiles),1);
for i=1:length(imageFiles)
    I = imread(strcat('Images/',imageFiles(i).name));
    I_gray = rgb2gray(I);

    binaryTolerance = 0.2;
    I_binarized = imbinarize(I_gray,binaryTolerance);
    [I_boundaries,L,n,A] = bwboundaries(I_binarized);
    
    for j=1:length(I_boundaries)
        %%%Ignore objects with small boundaries (background noise)
        if length(I_boundaries{j}(:,1)) < length(I_gray(:,1))*0.2
            continue
        end
        b = I_boundaries{j};
        %%%% Plotting grayscale image overlaid with cube outline
        %%%% and geometric centroid overlaid
        if plotGrayscale == 1
            figure
            imshow(I_gray,'InitialMagnification',800);
            title(['Image Number: ' , imageFiles(i).name])
            hold on
            sz = 200;
            scatter(mean(b(:,2)),mean(b(:,1)),sz,'r','+');
            plot(b(:,2),b(:,1),'g','LineWidth',3);
            saveas(gcf,['OutlinedImageOutputs/','outlined_',imageFiles(i).name])
        end
    end
    
    %%%%% Crop binarized image to the region containing the cube, allowing
    %%%%% for accurate pixel count (binary pixels == 1)
    boundaryXStart = min(b(:,2));
    boundaryXEnd = max (b(:,2));
    boundaryYStart = min(b(:,1));
    boundaryYEnd = max(b(:,2));
    
    image_cropped = imcrop(I_binarized,[boundaryXStart,boundaryYStart,...
        boundaryXEnd-boundaryXStart,boundaryYEnd-boundaryYStart]);
    number_of_pixels(i) = length(find(image_cropped==1));
    
    if plotBinarized == 1
        figure
        imshow(image_cropped,'InitialMagnification','fit');
        title({['Image Number: ' , imageFiles(i).name] , ...
            ['Number of Pixels: ',num2str(number_of_pixels(i))]})
        saveas(gcf,['BinarizedImageOutputs/','binarized_',imageFiles(i).name]);
    end
   
end

%% Pixel Analysis
