function [ new_img ] = undistord( BW, k )
%UNDISTORD Summary of this function goes here
%   Detailed explanation goes here
    [M, N] = size(BW);
    new_img = zeros(M, N);
    
    center=[round(N/2) round(M/2)];
    
    for j = 1:M
        for i = 1:N

            xd = i - center(1);
            yd = j - center(2);

            rd = sqrt(xd*xd + yd*yd);
            if 1 + k*rd^2 == inf
                x_u = N;
                y_u = M;
            else
                x_u = round(xd * (1 + k*(rd^2)));
                y_u = round(yd * (1 + k*(rd^2)));
            end
            
            x_u = x_u + center(1);
            y_u = y_u + center(2);
            
            if x_u <= 0 
                x_u = 1;
            elseif x_u > N
                x_u = N;
            end
            
            if y_u <= 0
                y_u = 1;
            elseif y_u > M 
                y_u = M;
            end
            
            
            if x_u > 0 && x_u <= N && y_u > 0 && y_u <= M
                new_img(y_u, x_u) = BW(j, i);
            end
        end
    end
end

