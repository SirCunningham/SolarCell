data=load('superconkarlhannesalex.txt');
T=data(:,4)
UA=data(:,3)-min(data(:,3))
cutoff=230
plot(T(1:cutoff),UA(1:cutoff),'b.')
hold on
plot(T(cutoff+1:end),UA(cutoff+1:end),'r.')
xlabel('T [K]')
ylabel('U_A [V]')
legend('Cooling','Heating','Location','Northwest')
xlim([min(T)-2,max(T)+2])
ylim([min(UA)-0.001,max(UA)+0.001])