function illustration( original, BW, lines )
    [M, N] = size(BW);
        
    figure; imshow(original); title('Least square lines') ; hold on;
    error = 0;
    mark = zeros(length(lines), 1);
    for j = 1:length(lines)
        if mark(j) == 1
            continue;
        end
            
        similar_lines = [];
        for i = 1:length(lines)
            if similar_slope(lines(j), lines(i))
                xy = [lines(i).point1; lines(i).point2];
                plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
                
                mark(i) = 1;
                similar_lines = [lines(i).point1(1), lines(i).point1(2); lines(i).point2(1), lines(i).point2(2); similar_lines];
            end
        end
        
        xs = similar_lines(:, 1);
        ys = similar_lines(:, 2);
        p = polyfit(xs, ys, 1);
        
        x = 0:0.1:1000;
        y = p(1)*x + p(2);
        
        xy = [lines(1).point1; lines(1).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
        plot(x(:),y(:),'LineWidth',2,'Color','blue');

    end
end

function bool = similar_slope(line1, line2) 
    if line1.point1(1) < line1.point2(1)
        min_x = line1.point1(1);
        max_x = line1.point2(1);
    else
        min_x = line1.point2(1);
        max_x = line1.point1(1);
    end

    if line1.point1(2) < line1.point2(2)
        min_y = line1.point1(2);
        max_y = line1.point2(2);
    else
        min_y = line1.point2(2);
        max_y = line1.point1(2);
    end

    threshold = 15;
    bool = (line2.point1(1) < max_x + threshold && line2.point1(1) > min_x - threshold && ... 
            line2.point2(1) < max_x + threshold && line2.point2(1) > min_x - threshold) || ...
           (line2.point1(2) < max_y + threshold && line2.point1(2) > min_y - threshold && ... 
            line2.point2(2) < max_y + threshold && line2.point2(2) > min_y - threshold);

    angle1 = atan((line1.point1(2) - line1.point2(2))/(line1.point1(1) - line2.point2(1))) + 2*pi;
    angle2 = atan((line2.point1(2) - line2.point2(2))/(line2.point1(1) - line2.point2(1))) + 2*pi;

%     distancePointToLineSegment(line1.point1, line2.point1, line2.point2)
%     distancePointToLineSegment(line1.point2, line2.point1, line2.point2)
    
    bool = bool && rad2deg(abs(angle1 - angle2)) < 10;
    bool = bool && distancePointToLineSegment(line1.point1, line2.point1, line2.point2) < 100 && distancePointToLineSegment(line1.point2, line2.point1, line2.point2) < 100;
%     
%     if rad2deg(abs(angle1 - angle2)) < 10;
%         %line1.point1, line2.point1, line2.point2
%         bool = distancePointToLineSegment(line1.point1, line2.point1, line2.point2) < threshold && distancePointToLineSegment(line1.point2, line2.point1, line2.point2) < threshold;
%     else
%         bool = false;
%     end
end

function d = distancePointToLineSegment(pt, v1, v2)
    % p is a point
    % a is the start of a line segment
    % b is the end of a line segment
    a = [0; v1(1) - v2(1); v1(2) - v2(2)];
    b = [0; pt(1) - v2(1); pt(2) - v2(2)];
    d = norm(cross(a,b)) / norm(a);
end