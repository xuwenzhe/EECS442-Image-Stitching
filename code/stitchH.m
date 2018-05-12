function result = stitchH(img_src, H, img_des)
    [~, xdata, ydata] = imtransform(img_src,maketform('projective',H'));

    xdata_out=[min(1,xdata(1)) max(size(img_des,2), xdata(2))];
    ydata_out=[min(1,ydata(1)) max(size(img_des,1), ydata(2))];

    result1 = imtransform(img_src, maketform('projective',H'),...
        'XData',xdata_out,'YData',ydata_out);
    result2 = imtransform(img_des, maketform('affine',eye(3)),...
        'XData',xdata_out,'YData',ydata_out);
    result = result1 + result2;
    overlap = (result1 > 0.0) & (result2 > 0.0);
    result_avg = (result1/2 + result2/2); % Note overflow!
    % extra credit: Now and Then
    % result_avg = (result1);
    
    result(overlap) = result_avg(overlap);
end