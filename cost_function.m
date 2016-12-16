function [ cost ] = cost_function( k, BW )
    
    % Correct the image based on the current value of k
    newEdgeImage = undistord(BW, k);
    
    [H,theta,rho] = hough(newEdgeImage);
    P = houghpeaks(H,50,'threshold',ceil(0.3*max(H(:))));
    
    lines = houghlines(newEdgeImage,theta,rho,P,'FillGap',10, 'MinLength',50);
    
    cost = distortion_error(newEdgeImage, lines);
end

