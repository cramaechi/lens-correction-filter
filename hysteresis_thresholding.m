function [highThresholdedImage,lowThresholdedImage,edgeLinkedImage] = hysteresis_thresholding(nms_img,nms_imgv,gradient_direction)

u = unique(nms_imgv);
histogram = hist(nms_imgv,numel(u));
histogramv = histogram(:);
n = numel(histogramv);
[r,c] = size(nms_img);

l = 0;
mode = 0;
modeIndex = 0;

for i = 1:n
    if (histogram(i) ~= max(histogram) && histogram(i) > l)
        mode = u(i);
        modeIndex = i;
        l = histogramv(i);
    end
end

minDistanceApart = 1300;
secondMode = 0;
secondModeIndex = 0; %#ok<NASGU>
l2 = 0;

if mode >= 0.8
    for j = (modeIndex-minDistanceApart):-1:1 
        if (histogram(j) > secondMode && histogram(j-1) >= (histogram(j)/2))
            secondMode = u(j);
            secondModeIndex = j; %#ok<NASGU>
        end
    end
else
     for j = (modeIndex+minDistanceApart):length(histogram) 
        if (histogram(j) > l2 && histogram(j-1) < histogram(j) && histogram(j-1) >= (histogram(j)/2) && histogram(j+1) < histogram(j) && histogram(j+1) >= (histogram(j)/2) && histogram(j+1) <= numel(histogram))
            secondMode = u(j);
            secondModeIndex = j; %#ok<NASGU>
            l2 = histogram(j);
        end
     end
end

highThreshold = (mode+secondMode)/2;
lowThreshold = highThreshold/2;
highThresholdedImage = nms_img;
lowThresholdedImage = ones(r,c);

for row = 1:r
    for column = 1:c
        if mode >= 0.8 && highThresholdedImage(row,column) < highThreshold
            highThresholdedImage(row,column) = 1;
        elseif mode >= 0.8 && highThresholdedImage(row,column) > highThreshold
            highThresholdedImage(row,column) = 0;
        elseif mode < 0.8 && highThresholdedImage(row,column) < highThreshold 
            highThresholdedImage(row,column) = 0;
        elseif mode < 0.8 && highThresholdedImage(row,column) > highThreshold && ((row+1) <= r || (row-1) >= 1 || (column+1) <= c || (column-1) >= 1)
            highThresholdedImage(row,column) = 1;
        end
        
        if mode < 0.8 && highThresholdedImage(row,column) > highThreshold && ((row+1) > r || (row-1) < 1 || (column+1) > c || (column-1) < 1)
            highThresholdedImage(row,column) = 0;
        end
    end
end

for row  = 1:r
    for column = 1:c
        if highThresholdedImage(row,column) == 1 && abs(round(radtodeg(gradient_direction(row,column))/45))*45 == 0
            if (row+1) <= r && nms_img(row+1,column) > lowThreshold && nms_img(row+1,column) <= highThreshold
                lowThresholdedImage(row+1,column) = 1;
            elseif (row+1) <= r && nms_img(row+1,column) <= lowThreshold
                lowThresholdedImage(row+1,column) = 0;
                %break;
            end
            
            if (row-1) >= 1 && nms_img(row-1,column) > lowThreshold && nms_img(row-1,column) <= highThreshold
                lowThresholdedImage(row-1,column) = 1;
            elseif (row-1) >= 1 && nms_img(row-1,column) <= lowThreshold
                lowThresholdedImage(row-1,column) = 0;
                %break;
            end
        elseif highThresholdedImage(row,column) == 1 && abs(round(radtodeg(gradient_direction(row,column))/45))*45 == 45
           if (row+1) <= r && (column+1) <= c && nms_img (row+1,column+1) > lowThreshold && nms_img(row+1,column+1) <= highThreshold
                lowThresholdedImage(row+1,column+1) = 1;
            elseif (row+1) <= r && (column+1) <= c && nms_img(row+1,column+1) <= lowThreshold
                lowThresholdedImage(row+1,column+1) = 0;
                %break;
            end
            
            if (row-1) >= 1 && (column-1) >= 1 && nms_img(row-1,column-1) > lowThreshold && nms_img(row-1,column-1) <= highThreshold
                lowThresholdedImage(row-1,column-1) = 1;
            elseif (row-1) >=1 && (column-1) >= 1 && nms_img(row-1,column-1) <= lowThreshold
                lowThresholdedImage(row-1,column-1) = 0;
                %break;
            end
        elseif highThresholdedImage(row,column) == 1 && abs(round(radtodeg(gradient_direction(row,column))/45))*45 == 90
            if (column-1) >= 1 && nms_img(row,column-1) > lowThreshold && nms_img(row,column-1) <= highThreshold
                lowThresholdedImage(row,column-1) = 1;
            elseif(column-1) >= 1 && nms_img(row,column-1) <= lowThreshold
                lowThresholdedImage(row,column-1) = 0;
                %break;
            end
            
            if (column+1) <= c && nms_img(row,column+1) > lowThreshold && nms_img(row,column+1) <= highThreshold
                lowThresholdedImage(row,column+1) = 1;
            elseif (column+1) <= c && nms_img(row,column+1) <= lowThreshold
                lowThresholdedImage(row,column+1) = 0;
                %break;
            end
        elseif highThresholdedImage(row,column) == 1 && abs(round(radtodeg(gradient_direction(row,column))/45))*45 == 135
            if (column-1) >= 1 && (row+1) <= r && nms_img(row+1,column-1) > lowThreshold && nms_img(row+1,column-1) <= highThreshold
                lowThresholdedImage(row+1,column-1) = 1;
            elseif (column-1) >= 1 && (row+1) <= r && nms_img(row+1,column-1) <= lowThreshold 
                lowThresholdedImage(row+1,column-1) = 1;
                %break;
            end
            
            if (column+1) <= c && (row-1) >= 1 && nms_img(row-1,column+1) > lowThreshold && nms_img(row-1,column+1) <= highThreshold
                lowThresholdedImage(row-1,column+1) = 1;
            elseif (column+1) <= c && (row-1) >= 1 && nms_img(row-1,column+1) <= lowThreshold
                lowThresholdedImage(row-1,column+1) = 0;
                %break;
            end
        elseif highThresholdedImage(row,column) == 0
            lowThresholdedImage(row,column) = 0;
        end
    end
end

edgeLinkedImage = link_edges(highThresholdedImage,highThreshold,lowThresholdedImage,nms_img,gradient_direction);

end