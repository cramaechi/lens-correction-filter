function [gradient_magnitude_x,gradient_magnitude_y,gradient_magnitude,gradient_direction] = computeGradient(distorted_img)

%Generates 3x3 Gaussian smoothing filter.
gaussian_filter = fspecial('gaussian');
%Convolves both the original image and the Gaussian filter to produce a
%smoothed image.
smooth_img = imfilter(distorted_img,gaussian_filter,'conv');
%Generates a Sobel filter that approximates a horizontal gradient of an
%image.
sobel_filtery = fspecial('sobel');
%Generates a Sobel filter that approximates a vertical gradient of an
%image.
sobel_filterx = sobel_filtery';
%Convolves the smoothed image with the sobel filter to approximate the
%vertical gradient.]
gradient_magnitude_x = imfilter(double(smooth_img),sobel_filterx,'conv');
%Convolves the smoothed image with the sobel filter to approximate the
%horizontal gradient.
gradient_magnitude_y = imfilter(double(smooth_img),sobel_filtery,'conv');

[r,c] = size(distorted_img);
gradient_magnitude = zeros(r,c);
gradient_direction = zeros(r,c);

%Computes the gradient magnitude/direction at each pixel in the original image.
for row = 1:r
    for column = 1:c
        gradient_magnitude(row,column) = sqrt(gradient_magnitude_x(row,column).^2 + gradient_magnitude_y(row,column).^2);
        gradient_direction(row,column) = atan(gradient_magnitude_y(row,column)/gradient_magnitude_x(row,column));
    end
end

gradient_magnitude_x = mat2gray(gradient_magnitude_x);
gradient_magnitude_y = mat2gray(gradient_magnitude_y);
gradient_magnitude = mat2gray(gradient_magnitude);

end
