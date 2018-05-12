function H = homography_fit(XY, XY_)
    A = [];
    for i = 1:size(XY,1)
        Xi = [XY(i,:)';1];
        xi_ = XY_(i,1);
        yi_ = XY_(i,2);
        
        A = cat(1,A,cat(2,zeros(1,3),Xi',-yi_*Xi'));
        A = cat(1,A,cat(2,Xi',zeros(1,3),-xi_*Xi'));
    end
    [~,~,V]=svd(A); 
    H = V(:,end);
    H = reshape(H,[3 3])';
end

