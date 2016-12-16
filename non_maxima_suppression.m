function [nms_img,nms_imgv] = non_maxima_suppression(gm_img,gd)

nms_img = gm_img;
nms_imgv = gm_img(:);
[r,c] = size(nms_img);

for row  = 1:r
    for column = 1:c
        if abs(round(radtodeg(gd(row,column))/45)*45) == 0
            if (column-1) >= 1 && (column+1) <= c
                if (nms_img(row,column) <= nms_img(row,column-1) || nms_img(row,column) <= nms_img(row,column+1))
                    nms_img(row,column) = 0.0;
                end
            elseif (column-1) < 1
                if (nms_img(row,column) <= nms_img(row,column+1))
                    nms_img(row,column) = 0.0;
                end
            elseif (column+1) > c
                if (nms_img(row,column) <= nms_img(row,column-1))
                    nms_img(row,column) = 0.0;
                end
            end
        elseif  abs(round(radtodeg(gd(row,column))/45)*45) == 45
            if (row-1) < 1 && (column+1) > c && (row+1) <= r && (column-1) >= 1
                if nms_img(row,column) <= nms_img(row+1,column-1)
                    nms_img(row,column) = 0.0;
                end
            elseif (row-1) >= 1 && (column+1) <= c && (row+1) > r && (column-1) < 1
                if nms_img(row,column) <= nms_img(row-1,column+1)              
                    nms_img(row,column) = 0.0;
                end
            elseif (row-1) >= 1 && (column+1) <= c && (row+1) <= r && (column-1) >= 1
                if nms_img(row,column) <= nms_img(row-1,column+1) || nms_img(row,column) <= nms_img(row+1,column-1)
                    nms_img(row,column) = 0.0;
                end
            end
        elseif abs(round(radtodeg(gd(row,column))/45)*45) == 90
            if (row-1) < 1
                if nms_img(row,column) <= nms_img(row+1,column)
                    nms_img(row,column) = 0.0;
                end
            elseif (row+1) > r
                if nms_img(row,column) <= nms_img(row-1,column)
                    nms_img(row,column) = 0.0;
                end
            elseif (row-1) >= 1 && (row+1) <= r
                if nms_img(row,column) <= nms_img(row-1,column) || nms_img(row,column) <= nms_img(row+1,column)
                    nms_img(row,column) = 0.0;
                end
            end
        elseif abs(round(radtodeg(gd(row,column))/45)*45) == 135
            if (row-1) < 1 && (column-1) < 1 && (row+1) <= r && (column+1) <= c
                if nms_img(row,column) <= nms_img(row+1,column+1)
                    nms_img(row,column) = 0.0;
                end
            elseif (row-1) >= 1 && (column-1) >=1 && (row+1) > r && (column+1) > c
                if nms_img(row,column) <= nms_img(row-1,column-1)
                    nms_img(row,column) = 0.0;
                end
            elseif (row+1) <= r && (column+1) <= c && (row-1) >= 1 && (column-1) >=1
                if nms_img(row,column) <= nms_img(row+1,column+1) || nms_img(row,column) <= nms_img(row-1,column-1)
                    nms_img(row,column) = 0.0;
                end
            end
        end        
    end
end
end