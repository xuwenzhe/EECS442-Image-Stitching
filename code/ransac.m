function [H, num_inliers, residual] = ransac(XY_src, XY_des, num_ransac_iter,...
    homography_fit,homography_tf)
    
    num_inliers = 0;
    plot_num_inliers = zeros(1,num_ransac_iter);
    plot_residual = zeros(1,num_ransac_iter);
    for i = 1:num_ransac_iter
        ind = randperm(size(XY_src,1));
        ind_s = ind(1:4);
        ind_r = ind(5:end);
        
        
        tmp_H = homography_fit(XY_src(ind_s,:), XY_des(ind_s,:));
        predict = homography_tf(XY_src(ind_r,:),tmp_H);
        
        dists = sum((XY_des(ind_r,:) - predict).^2,2);
        
        inlier_idx = find(dists < 0.3);
        tmp_num_inliers = length(inlier_idx);
        
        if tmp_num_inliers > num_inliers
            H = tmp_H;
            num_inliers = tmp_num_inliers;
            residual = mean(dists(inlier_idx));
        end
        plot_num_inliers(i) = num_inliers;
    end
%     figure;
%     plot(1:num_ransac_iter,plot_num_inliers,'b*')
%     xlabel('iteration')
%     ylabel('num of inliers')
%     set(gca,'fontsize',20)
end

