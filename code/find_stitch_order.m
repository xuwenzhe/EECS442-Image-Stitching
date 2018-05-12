function image_order = find_stitch_order(images)
    N = length(images);
    image_order = zeros(1,N);
    inliers_matrix = zeros(N,N);
    for i = 1:N
        for j = i+1:N
            [~,~,num_inliers,~] = stitch_pair(images{i},images{j});
            inliers_matrix(i,j) = num_inliers;
            inliers_matrix(j,i) = num_inliers;
        end
    end
    
    % a threshhold should be used to determine whether an image should be
    % stitched into the resultant image set.
    
    inliers_sum = sum(inliers_matrix,2);
    [~,idx] = max(inliers_sum);
    image_order(1) = idx;
    
    included = zeros(1,N);
    included(idx) = 1;
    
    candidate_idx = [];
    candidate_inliers = [];
    
    for i = 1:N
        if i ~= idx
            candidate_inliers = [candidate_inliers, inliers_matrix(idx,i)];
            candidate_idx = [candidate_idx, i];
        end
    end
    
    for i = 2:N
        [~,idx] = max(candidate_inliers);
        image_order(i) = candidate_idx(idx);
        included(candidate_idx(idx)) = 1;
        
        tmp_candidate_inliers = [];
        tmp_candidate_idx = [];
        for j = 1:length(candidate_idx)
            if included(candidate_idx(j)) == 0
                tmp_candidate_inliers = ...
                    [tmp_candidate_inliers,candidate_inliers(j)];
                tmp_candidate_idx = [tmp_candidate_idx,candidate_idx(j)];
            end
        end
        for j = 1:N
            if included(j) == 0
                tmp_candidate_inliers = [tmp_candidate_inliers,...
                    inliers_matrix(candidate_idx(idx),j)];
                tmp_candidate_idx = [tmp_candidate_idx,j];
            end
        end
        
        candidate_inliers = tmp_candidate_inliers;
        candidate_idx = tmp_candidate_idx; 
    end
end

