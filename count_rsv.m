function freq_rsv = count_rsv(ac_code,tbl_ac)
freq_rsv = zeros(numel(tbl_ac(:,1)),2); %rsv-vlc mapping
num_block = size(ac_code);
for i = 1 : num_block
    for j = 1 : length([ac_code{i,1}{:,1}])
        cur_row = ac_code{i,1}{j,1};
        freq_rsv(cur_row,1) = freq_rsv(cur_row,1) + 1;
    end
end
freq_rsv(:,2) = tbl_ac(:,3);
% ����GA֮ǰ��Ƶ������Ŀ��ȷ�������غ�Ҫ�����С��ֵ������ȷ��
freq_rsv = sortrows(freq_rsv, -1);
end
