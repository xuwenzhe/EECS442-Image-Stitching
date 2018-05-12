function [img_res,H,num_inliers,residual] = stitch_pair(img_src, img_des)
    gd_src = im2double(rgb2gray(img_src));
    gd_des = im2double(rgb2gray(img_des));
    
    harris_sigma = 2;
    harris_thresh = 0.05;
    harris_radius = 2;
    [~,y_src,x_src] = harris(gd_src,harris_sigma,harris_thresh,harris_radius,0);

    [~,y_des,x_des] = harris(gd_des,harris_sigma,harris_thresh,harris_radius,0);
    
    sift_radius = 5;
    descriptors_src = find_sift(gd_src,[x_src,y_src,...
        sift_radius*ones(length(x_src),1)],1.5);
    descriptors_des = find_sift(gd_des,[x_des,y_des,...
        sift_radius*ones(length(x_des),1)],1.5);
    
    num_putative_matches = 200;
    [matches_src,matches_des] = select_putative_matches(...
        descriptors_src,descriptors_des,num_putative_matches);
    XY_src = [x_src(matches_src),y_src(matches_src)];
    XY_des = [x_des(matches_des),y_des(matches_des)];
%     length(XY_src)
    num_ransac_iter = 5000;
    [H,num_inliers,residual] = ransac(XY_src,XY_des,num_ransac_iter,...
        @homography_fit,@homography_tf);
    
    img_res = stitchH(img_src,H,img_des);
    
%     figure, imagesc(gd_src), axis image, colormap(gray), hold on
%     plot(x_src,y_src,'ys'),
%     plot(x_src(matches_src),y_src(matches_src),'bs'),
%     predict = homography_tf(XY_src,H);
%     dists = sum((XY_des - predict).^2,2);
%     inlier_idx = find(dists < 0.3);
%     plot(XY_src(inlier_idx,1),XY_src(inlier_idx,2),'gs'),
%     
%     figure, imagesc(gd_des), axis image, colormap(gray), hold on
%     plot(x_des,y_des,'ys'),
%     plot(x_des(matches_des),y_des(matches_des),'bs'),
%     plot(XY_des(inlier_idx,1),XY_des(inlier_idx,2),'gs'),
end

