%%%%%Dylan Bossie
%%%%%10/7/2018
%%%%%VANTAGE
%%%%%PDR Object Detection Feasibility
clc
close all
clear

%Resolution of Jerry's camera
%jerry = 7360*4912;

%%% Options to plot grayscale centroid and binarized images
plotGrayscale = 1;
plotBinarized = 0;


%%% Search desired image folder for relevant images
imageDirectory = 'Images/';
images = strcat(imageDirectory,'8*');
imageFiles = dir(images);

%Preallocate array to store number of pixels for the cubesats in each image
number_of_pixels = zeros(length(imageFiles),1);
FindCentroid(imageFiles,plotGrayscale,number_of_pixels,plotBinarized,imageDirectory);
