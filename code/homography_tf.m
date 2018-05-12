function XY_ = homography_tf(XY,H)
    Xi = cat(1, XY', ones(1, size(XY, 1)));
    Xi_ = H*Xi;
    XY_(:,1) = (Xi_(1,:)./Xi_(3,:))';
    XY_(:,2) = (Xi_(2,:)./Xi_(3,:))';
end

