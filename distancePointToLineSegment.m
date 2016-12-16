
function d = distancePointToLineSegment(pt, v1, v2)
    % p is a point
    % a is the start of a line segment
    % b is the end of a line segment
    a = [0; v1(1) - v2(1); v1(2) - v2(2)];
    b = [0; pt(1) - v2(1); pt(2) - v2(2)];
    d = norm(cross(a,b)) / norm(a);
end