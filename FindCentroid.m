function FindCentroid(imageFiles,plotGrayscale,~,plotBinarized)
%Number of expected objects (sad I know but it's for proving tracking not
%realistic tracking o.O
n=2;

for i=1:length(imageFiles)
    I = imread(strcat('Images/',imageFiles(i).name));
    I_gray = rgb2gray(I);

    binaryTolerance = 0.1;
    I_binarized = imbinarize(I_gray,binaryTolerance);
    [I_boundaries,~,~,~] = bwboundaries(I_binarized);
    
    %%%%% Find the largest boundaries (the cubesats)
    [s,~] = cellfun(@size,I_boundaries);
    [~,si] = sort(s,'descend');
    I_boundaries = I_boundaries(si,:);
    
    if plotGrayscale == 1
        figure
        imshow(I_gray,'InitialMagnification',800);
        hold on
        title(['Image ' , num2str(i)]);
        sz = 200;
    end
    
    for j=1:n
        b = I_boundaries{j};
        %%%% Plotting grayscale image overlaid with cube outline
        %%%% and geometric centroid overlaid
        if plotGrayscale == 1
            scatter(mean(b(:,2)),mean(b(:,1)),sz,'r','+');
            str = num2str(j);
            text(mean(b(:,2)),mean(b(:,1))+200,str,'Color','red',...
                'FontSize',15);
            plot(b(:,2),b(:,1),'g','LineWidth',3);
        end
    end
    
    if plotGrayscale == 1
        saveas(gcf,['OutlinedImageOutputs/','outlined_multitracking'...
            ,imageFiles(i).name]);
    end
    
    %number_of_pixels(i) = FindCubeSatPixels(b,imageFiles(i).name,I_binarized,...
    %    plotBinarized);
    FindCubeSatPixels(b,imageFiles(i).name,I_binarized,...
        plotBinarized);
    
end

end