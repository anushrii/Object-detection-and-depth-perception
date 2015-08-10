function [x, y, d] = myAlgorithm(im)


load ('best.mat')  
   P_class_f = sum( P_class_floor)/numel( P_class_floor);
    P_class_r = sum( P_class_redb)/numel( P_class_redb);
     P_class_w = sum( P_class_white)/numel( P_class_white);
  
 imm = imresize(im, 0.5);
 im = rgb2ycbcr(imm);
 
 %%%%%%%%%%%%%%%%%%%%red
 mur=sum(rgb_index_r,1)/size(rgb_index_r,1);
 xX = bsxfun(@minus,rgb_index_r,mur);
 Ar = (xX'*xX/size(rgb_index_r,1));

%for red

 %P_pixel_gvnred = zeros(size(im,1)*size(im,2),1);
X = reshape(im,[],3);
X= double(X);

P_pixel_gvnred = mvnpdf(X ,mur, Ar);

 %%%%%%%%%%%%%%%white
 muw=sum(rgb_index_w,1)/size(rgb_index_w,1);
 xX = bsxfun(@minus,rgb_index_w,muw);
 Aw = (xX'*xX/size(rgb_index_w,1));

P_pixel_gvnwhite = mvnpdf(X,muw, Aw);



%%%%%%%%%%%%%%%%%%%%%%floor

 muf=sum(rgb_index_f,1)/size(rgb_index_f,1);
 xX = bsxfun(@minus,rgb_index_f,muf);
 Af = (xX'*xX/size(rgb_index_f,1));

P_pixel_gvnfloor = mvnpdf(X,muf, Af);


P_red_gvnpixel = zeros(size(im,1)*size(im,2),1);

for i=1:zeros(size(im,1)*size(im,2),1)
    

r = P_pixel_gvnred(i)*P_class_r;
w = P_pixel_gvnwhite(i)*P_class_w;
f = P_pixel_gvnfloor(i)*P_class_f;
Sum_ = r + w +r;
P_red_gvnpixel(i) = r/Sum_;

end

img = reshape(P_pixel_gvnred, size(im,1),size(im,2));
figure, imagesc(img)
%% thresholding for P_red_gvnpixel
% a = find(P_red_gvnpixel>0.00001);
a = find(P_pixel_gvnred>0.0000022);
b = zeros(size(img));
b(a) = 1;


L = bwlabeln(b,26);
figure, imshow(L)





 CH = bwconvhull(L, 'object');
imshow(CH)
display('checking for small areas')

BW = bwareaopen(CH, 20 ,26);
   figure, imshow(BW)

   display(' checking for connected components')
   CC = bwconncomp(BW,26);
   BB = regionprops(CC,'BoundingBox','Centroid','FilledArea');

   x=0;
   y=0;
for i = 1:size(BB,1)
    AR = BB(i).BoundingBox(3)/BB(i).BoundingBox(4);
    
    q = BB(i).FilledArea;
    %% conditions for selecting the barrel;s Bounding box
     if AR > 0.30 && AR <0.8 && q > 400
         
    figure, imshow(imm)
    hold on
rectangle('Position',BB(i).BoundingBox, 'EdgeColor', [1 1 0])
 centroids = cat(1, BB.Centroid);

  x = centroids(i,1);
  y= centroids(i,2);
   hold on
   plot(x, y , 'g+')  
         
     end
    q = sqrt(BB(i).FilledArea);
end
hold off
% for checking the depth using Knn search algorithm
Q = [ q AR];
load('depthDAT')


IDX = knnsearch(DATA,Q);
d = Depth(IDX);


