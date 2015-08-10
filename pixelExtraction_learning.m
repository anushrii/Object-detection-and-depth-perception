dirstruct = dir('*.png');
BW_red=cell(1,length(dirstruct));
BW_floor=cell(1,length(dirstruct));
BW_white=cell(1,length(dirstruct));

rgb_index_red=cell(1,length(dirstruct));
rgb_index_white=cell(1,length(dirstruct));
rgb_index_floor=cell(1,length(dirstruct));



for i = 1:29,
% Current test image
im = imread(dirstruct(i).name);

im = rgb2ycbcr(im);


%P_class_redb= cell(length(distruct));
%P_class_white= cell(length(distruct));
%P_class_floor= cell(length(distruct));

load('goodstuff.mat','BW_red','BW_white','BW_floor');

% BW_red{i} = roipoly(im);
% BW_white{i} = roipoly(im);
% BW_floor{i} = roipoly(im);
 


%probability of class red barrel
 no_pixREDB = length (find(BW_red{i}));
 total_pixs = numel(BW_red{i});
 P_class_redb(i) = no_pixREDB / total_pixs;
 
  no_pixwhite = length (find(BW_white{i}));
 total_pixs = numel(BW_white{i});
 P_class_white(i) = no_pixwhite / total_pixs;
 
  no_pixfloor = length (find(BW_floor{i}));
 total_pixs = numel(BW_floor{i});
 P_class_floor(i) = no_pixfloor / total_pixs;



  
 rgb_index_red{i} = im_rgblist(im, BW_red{i}) ;      
 rgb_index_white{i} = im_rgblist(im, BW_white{i}) ;
 rgb_index_floor{i} = im_rgblist(im, BW_floor{i}) ;
 
end
 

  rgb_index_r = cat(1, rgb_index_red{:});
  rgb_index_w = cat(1, rgb_index_white{:});
  rgb_index_f = cat(1, rgb_index_floor{:});