%Author: Chibuikem Amaechi
%Date: 11/17/2013
%Course: Digital Image Processing
%Project Name: Distortion Correction
%
%---------------------------------------------------------------
% How to call function: canny_edge_detector('distort.png');
%---------------------------------------------------------------
function [edgeLinkedImage, distorted_img] = canny_edge_detector(input_img)

distorted_img = imread(input_img);

[gradient_magnitude_x,gradient_magnitude_y,gradient_magnitude,gradient_direction] = computeGradient(distorted_img);
[nms_img,nms_imgv] = non_maxima_suppression(gradient_magnitude,gradient_direction);
[highThresholdedImage,lowThresholdedImage,edgeLinkedImage] = hysteresis_thresholding(nms_img,nms_imgv,gradient_direction);

subplot(3,3,1), imshow(distorted_img); title('Distorted Image');
subplot(3,3,2), imshow(gradient_magnitude_x); title('Horizontal Gradient')
subplot(3,3,3), imshow(gradient_magnitude_y); title('Vertical Gradient')
subplot(3,3,4), imshow(gradient_magnitude); title('Gradient Magnitude')
subplot(3,3,5), imshow(nms_img); title('Non-maxima Suppresed Image')
subplot(3,3,6), imshow(highThresholdedImage,[0 1]); title('High Thresholded Image')
subplot(3,3,7), imshow(lowThresholdedImage,[0 1]); title('Low Thresholded Image')
figure, imshow(edgeLinkedImage,[0 1]); title('Binary image with linked edges')


end