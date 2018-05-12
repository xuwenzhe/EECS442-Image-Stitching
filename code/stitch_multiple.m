function [img_res,H,num_inliers,residual] = stitch_multiple(images)
    image_order = find_stitch_order(images)
    img_res = images{image_order(1)};
    figure;imshow(img_res)
    for i = 2:length(image_order)
        [img_res,H,num_inliers,residual] = ...
            stitch_pair(images{image_order(i)},img_res);
        figure;imshow(img_res)
    end
end

