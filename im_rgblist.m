function [rgb_index] = im_rgblist(img, BW)

BW = uint8(BW);
BB = regionprops(BW, 'BoundingBox'); 
small_img = imcrop(img, [BB.BoundingBox]); 
small_BW = imcrop(BW, [BB.BoundingBox]); 
pos_index = reshape(small_BW, [], 1);

rgb_temp = double(reshape(small_img(:,:,1), [], 1));
rgb_temp(~pos_index)= [];
rgb_index = rgb_temp;

rgb_temp = double(reshape(small_img(:,:,2), [], 1));
rgb_temp(~pos_index) = [];
rgb_index(:,2) = rgb_temp;


rgb_temp = double(reshape(small_img(:,:,3), [], 1));
rgb_temp(~pos_index) = [];
rgb_index(:,3) = rgb_temp;
end