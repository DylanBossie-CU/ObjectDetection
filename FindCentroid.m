function FindCentroid(imageFiles,plotGrayscale,number_of_pixels,plotBinarized)

for i=1:length(imageFiles)
    I = imread(strcat('Images/',imageFiles(i).name));
    I_gray = rgb2gray(I);

    binaryTolerance = 0.2;
    I_binarized = imbinarize(I_gray,binaryTolerance);
    [I_boundaries,~,~,~] = bwboundaries(I_binarized);
    
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
    
    number_of_pixels(i) = FindCubeSatPixels(b,imageFiles(i).name,I_binarized,...
        plotBinarized);
    
end

end