function K = ker_Gaussian(fea_a,fea_b,options)

if ~isfield(options,'width') %~代表 非 ，检查结构体options是否包含由width指定域，如果包含，返回逻辑1；
%                               如果不包含width域或者options不是结构体类型的，返回逻辑0.
     options.width =0.75;
end
D = EuDist(fea_a,fea_b); %自编函数，见下方
K = exp(-D/(2*options.width^2));  %返回自然常数的 -D/(2*options.width^2) 次方
end

function D = EuDist(fea_a,fea_b)

    aa = sum(fea_a.*fea_a,2); % .*按位置依次相乘，得到的结果将作为新矩阵中相同位置的元素，对矩阵 fea_a.*fea_a 的行求和
    bb = sum(fea_b.*fea_b,2); % .*按位置依次相乘，得到的结果将作为新矩阵中相同位置的元素，对矩阵 fea_b.*fea_b 的行求和
    ab = fea_a*fea_b';  


    D = bsxfun(@plus,aa,bb') - 2*ab; %plus 加法，求（a-b）^2    bsxfun 对两个矩阵A和B之间的每一个元素进行指定的计算
    D(D<0) = 0;

end


