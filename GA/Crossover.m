function P = Crossover( P, r_c, N)
len_ind = length(P{1});    %Ⱦɫ�峤��
for i = 1:2:N-3        %����λ����
    if rand < r_c         %�������λ 
        pos = randi([1,len_ind]);
        temp = P{i}(1:pos);
      	P{i}(1:pos) = P{i+1}(1:pos);
     	P{i+1}(1:pos) = temp;
    end
end
end

