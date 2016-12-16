% detects and captures edges in an image
[edgeLinkedImage, distorted_img] = canny_edge_detector('distort4.png');

[H,theta,rho] = hough(edgeLinkedImage);
P = houghpeaks(H,50,'threshold',ceil(0.3*max(H(:))));

lines = houghlines(edgeLinkedImage,theta,rho,P,'FillGap',10, 'MinLength',50);
max_len = 0;

figure; imshow(distorted_img); title('Image with detected line segments'); hold on;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

% Compute the distortion error
error = cost_function(0, edgeLinkedImage);
'The distortion error is : '
error

% Do illustration on least square and stuff
illustration(distorted_img, edgeLinkedImage, lines);

% Estimate k
k = parameter_estimation(edgeLinkedImage);
'The parameter k is : '
k

% Fix the binary image based on the parameter k
I = undistord(edgeLinkedImage, k);
figure; imshow(I); title('Corrected binary image');

% Output the undistorted image
undistorted = undistord(distorted_img, k);
figure; imshow(uint8(undistorted)); title('Corrected grayscale image');
