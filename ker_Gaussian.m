function K = ker_Gaussian(fea_a,fea_b,options)

if ~isfield(options,'width') %~���� �� �����ṹ��options�Ƿ������widthָ������������������߼�1��
%                               ���������width�����options���ǽṹ�����͵ģ������߼�0.
     options.width =0.75;
end
D = EuDist(fea_a,fea_b); %�Աຯ�������·�
K = exp(-D/(2*options.width^2));  %������Ȼ������ -D/(2*options.width^2) �η�
end

function D = EuDist(fea_a,fea_b)

    aa = sum(fea_a.*fea_a,2); % .*��λ��������ˣ��õ��Ľ������Ϊ�¾�������ͬλ�õ�Ԫ�أ��Ծ��� fea_a.*fea_a �������
    bb = sum(fea_b.*fea_b,2); % .*��λ��������ˣ��õ��Ľ������Ϊ�¾�������ͬλ�õ�Ԫ�أ��Ծ��� fea_b.*fea_b �������
    ab = fea_a*fea_b';  


    D = bsxfun(@plus,aa,bb') - 2*ab; %plus �ӷ�����a-b��^2    bsxfun ����������A��B֮���ÿһ��Ԫ�ؽ���ָ���ļ���
    D(D<0) = 0;

end


