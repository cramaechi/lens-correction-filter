function edgeLinkedImage = link_edges(highThresholdedImage,highThreshold,lowThresholdedImage,nms_img,gradient_direction)

edgeLinkedImage = highThresholdedImage;
[r,c] = size(edgeLinkedImage);

for row = 1:r
    for column = 1:c 
        if edgeLinkedImage(row,column) == 1 && abs(round(radtodeg(gradient_direction(row,column))/45))*45 == 0
            if (row+1) <= r && (row-1) >= 1 && (nms_img(row+1,column) <= highThreshold || nms_img(row-1,column) <= highThreshold)
                if lowThresholdedImage(row+1,column) == 1
                    edgeLinkedImage(row+1,column) = 1;
                end
                
                if lowThresholdedImage(row-1,column) == 1
                    edgeLinkedImage(row-1,column) = 1;
                end
            end
        elseif edgeLinkedImage(row,column) == 1 && abs(round(radtodeg(gradient_direction(row,column))/45))*45 == 45
            if (row+1) <= r && (column+1) <= c && (row-1) >= 1 && (column-1) >= 1 && (nms_img(row-1,column-1) <= highThreshold || nms_img(row+1,column+1) <= highThreshold)
                if lowThresholdedImage(row+1,column+1) == 1
                    edgeLinkedImage(row+1,column+1) = 1;
                end
                
                if lowThresholdedImage(row-1,column-1) == 1
                    edgeLinkedImage(row-1,column-1) = 1;
                end
            end
        elseif edgeLinkedImage(row,column) == 1 && abs(round(radtodeg(gradient_direction(row,column))/45))*45 == 90
            if (column-1) >=1 && (column+1) <= c && (nms_img(row,column-1) <= highThreshold || nms_img(row,column+1) <= highThreshold)
                if lowThresholdedImage(row,column-1) == 1
                    edgeLinkedImage(row,column-1) = 1;
                end
                
                if lowThresholdedImage(row,column+1) == 1 
                    edgeLinkedImage(row,column+1) = 1;
                end
            end
        elseif edgeLinkedImage(row,column) == 1 && abs(round(radtodeg(gradient_direction(row,column))/45))*45 == 135
                if (row-1) >= 1 && (column+1) <= c && (row+1) <= r && (column-1) >= 1 && (nms_img(row-1,column+1) <= highThreshold || nms_img(row+1,column-1) <= highThreshold)
                    if lowThresholdedImage(row-1,column+1) == 1
                       edgeLinkedImage(row-1,column+1) = 1;
                    end
                    
                    if lowThresholdedImage(row+1,column-1) == 1
                        edgeLinkedImage(row+1,column-1) = 1;
                    end
                end
        end
    end
end

end