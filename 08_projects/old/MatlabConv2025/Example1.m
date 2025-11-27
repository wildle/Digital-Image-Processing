% Kurt Niel / FH OOE / kurt.niel@fh-wels.at
% Jan. 2013 / Matlab R2011b
% EXAMPLE 1 - Convolution filter, Morphology for highlightning/segmenting objects 
%------------------------------------------------
% cleanup, parameters
clc;
clear all;
close all;

% load image data from file - e.g. from a color image here
IMclip = imread('BatteryClip.jpg');
IMrice = imread('rice.png');
IMcoins = imread('coins.png');
IMfabric = imread('fabric.png');
IMfabric = rgb2gray(IMfabric);

% make filter kernel
% filter no change
Fno = [0 0 0; 0 1 0; 0 0 0];
% filter mean/smoothing - like optical blurring
Fmeanc = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
Fmean = [1 1 1; 1 1 1; 1 1 1];
% filter horizontal edge emphasazing - Prewitt 
Fpreh = [-1 0 1; -1 0 1; -1 0 1];
Fprehn = [1 0 -1; 1 0 -1; 1 0 -1];
% filter vertical edge emphasazing - Prewitt
Fprev = [-1 -1 -1; 0 0 0; 1 1 1];
Fprevn = [1 1 1; 0 0 0; -1 -1 -1];
% filter edge emphazazing - Laplace
Flapl = [-1 -1 -1; -1 8 -1; -1 -1 -1];
% filter smoothing and detail emphazazing - Gauss
Fgausc = [1/16 2/16 1/16; 2/16 4/16 2/16; 1/16 2/16 1/16];
Fgaus = [1 2 1; 2 4 2; 1 2 1];

% apply filterkernel to image
IM = IMrice;
R = imfilter(IM, Fpreh);
% R  = imfilter(IM, Fgausc);
Rn = imfilter(IM, Fprehn);
Rv  = imfilter(IM, Fprev);
Rvn = imfilter(IM, Fprevn);
R =  max(R,Rn);
R =  max(R,Rv);
R =  max(R,Rvn);

% display the result
subplot(2,2,1);
imshow(IM,[0 255]);
subplot(2,2,2);
imhist(IM,256);
subplot(2,2,3);
imshow(R,[0 255]);
subplot(2,2,4);
imhist(R,256);
