% hubble.m
data = csvread('Hubble.csv');
dist = data(:,1);
velo = data(:,2);

dis_vs_velo = pinv(velo)*dist;
velo_vs_dis = pinv(dist)*velo;

fprintf('\ndis_vs_velo=%f\n\nvelo_vs_dis=%f\n\n',dis_vs_velo,velo_vs_dis);
u_data = mean(data);                                
[u,s,v] = svd(data-u_data);                             % Decentralization
decode = v(:,1);
pca = (data - u_data) * decode * decode' + u_data;      % PCA conpress & recover

plot(dist,velo,'bo',velo*dis_vs_velo,velo, dist,dist*velo_vs_dis, pca(:,1),pca(:,2))
legend('Data','Velo--dist','Dist--velo','PCA')
xlabel('Distance (10^6)parsecs')
ylabel('Velocity km/sec')

