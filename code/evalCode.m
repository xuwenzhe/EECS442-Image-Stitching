clear
clc

%% PART I
img_src = imread('../data/uttower_left.jpg');
img_des = imread('../data/uttower_right.jpg');

[img_res,H,num_inliers,residual] = stitch_pair(img_src,img_des);
figure;
imshow(img_res)

%% PART_II
% images{1} = imread('../data/hill/1.JPG');
% images{2} = imread('../data/hill/2.JPG');
% images{3} = imread('../data/hill/3.JPG');
% [img_res,H,num_inliers,residual] = stitch_multiple(images);
% figure;
% imshow(img_res);

% images{1} = imread('../data/ledge/1.JPG');
% images{2} = imread('../data/ledge/2.JPG');
% images{3} = imread('../data/ledge/3.JPG');
% [img_res,H,num_inliers,residual] = stitch_multiple(images);
% figure;
% imshow(img_res);

% images{1} = imread('../data/pier/1.JPG');
% images{2} = imread('../data/pier/2.JPG');
% images{3} = imread('../data/pier/3.JPG');
% [img_res,H,num_inliers,residual] = stitch_multiple(images);
% figure;
% imshow(img_res);



%% EXTRA CREDIT: Now and Then
% img_src = imread('../imgs/7then.png');
% img_des = imread('../imgs/7now.png');

%% EXTRA CREDIT: "pile" of input images
% d = dir('../imgs/glacier4/*.JPG');
% for i = 1:numel(d)
%     images{i} = imread(fullfile('../imgs/glacier4',d(i).name));
% end
% [img_res,H,num_inliers,residual] = stitch_multiple(images);
% figure;
% imshow(img_res);

