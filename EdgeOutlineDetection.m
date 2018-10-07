%Dylan Bossie
clc
close all
clear

imageFiles = dir('Images/8*');

jerry = 7360*4912;

number_of_pixels = zeros(length(imageFiles),1);

for i=1:length(imageFiles)
    I = imread(strcat('Images/',imageFiles(i).name));
    I_gray = rgb2gray(I);

    binaryTolerance = 0.2;
    I_binarized = imbinarize(I_gray,binaryTolerance);
    [I_boundaries,L,n,A] = bwboundaries(I_binarized);
    
    %figure
    %imshow(I_gray);
    hold on
    sz = 200;
    for j=1:length(I_boundaries)
        if length(I_boundaries{j}(:,1)) < 500
            continue
        end
        b = I_boundaries{j};
        %scatter(mean(b(:,2)),mean(b(:,1)),sz,'r','+');
        %plot(b(:,2),b(:,1),'g','LineWidth',3);
    end
    
    boundaryXStart = min(b(:,2));
    boundaryXEnd = max (b(:,2));
    boundaryYStart = min(b(:,1));
    boundaryYEnd = max(b(:,2));
    
    figure
    
    image_cropped = imcrop(I_binarized,[boundaryXStart,boundaryYStart,...
        boundaryXEnd-boundaryXStart,boundaryYEnd-boundaryYStart]);
    imshow(image_cropped);
    title(['Image Number: ' , imageFiles(i).name])
    
    number_of_pixels(i) = length(find(image_cropped==1));
   
end

%% Pixel Analysis
