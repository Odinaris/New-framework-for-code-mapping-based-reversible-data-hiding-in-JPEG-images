function opt_solution = GA(freq_rsv, payload,r_c,r_m)
%% Paramater setting
G = 50;    %��Ⱥ�Ĵ���
N = 200;    %��Ⱥ�Ĺ�ģ
% r_c = 0.8;   %������
% r_m = 0.3;   %������
L = 2;  %ÿ��RS�ɷ����δʹ��VLC�������ࣨ1��2��4��8��
%% Reduce solution size
N_used = 10;
freq = freq_rsv(:,1);
ind = find(freq>=payload);
if isempty(ind)
    fst_pos = 1; % first position of RSV
else
    fst_pos = ind(end);
end
if numel(freq)-fst_pos>=N_used
    n_max = N_used;%���ӳ�伯����Ŀ
else
    n_max = numel(freq)-fst_pos+1;
end
%% Initial
P = cell(N,1);
rng('shuffle');
for i=1:N
    P{i} = char((rand(1,n_max*L)>0.5)+'0');
end
%������Ӧ�ȳ�ֵ �洢ÿ����������Ӧ�� ��С�ļ��������洢 ÿ������С�ļ�������
[list_fit,list_E,list_elite] = deal(zeros(G,1),zeros(G,1),cell(G,1));
%% ��������
for i = 1:G
    %% ������Ӧ��
    [fits, prob, E] = Fitness(P, freq, fst_pos, payload, n_max, L);
    q = cumsum(prob);   %�ۼӸ���
    [max_fit, ind] = max(fits);  %�󵱴���Ѹ���
    p_elite = P{ind};    %��ĿǰΪֹ���λ��
    list_E(i) = E(ind); % �洢ÿ������������ֵ
    list_fit(i) = max_fit;	% �洢ÿ����������Ӧ��
    list_elite{i} = p_elite;
    P{N} = p_elite; %���ű���(��Ӣ����ѡ��)
    %% ���̶�ѡ��
    P = Select(P, N, q);
    %% ����
    P = Crossover(P, r_c, N);
    %% ����
    P = Mutation(P, r_m, N);
end
% plot(list_E)%��С�ļ����ͽ�������
[~,ind] = min(list_E);
opt_solution = zeros(1,numel(freq));
opt_solution(fst_pos:fst_pos+n_max-1) = bin2ints(list_elite{ind}, L);

end
