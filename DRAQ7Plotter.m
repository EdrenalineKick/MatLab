cd('C:\MicroscopyData\20180403_Draq7SeedingDensities')
load('DRAQ7.mat')
load('DRAQ7Day2.mat')
store = cat(2,eAverage,fAverage);
store = cat(2,store,gAverage);

eAverage2 = mean(EareaStore2,2);
fAverage2 = mean(FareaStore2,2);
gAverage2 = mean(GareaStore2,2);

store2 = cat(2,eAverage2,fAverage2);
store2 = cat(2,store2,gAverage2);

store = cat(1,store,store2)

time = 0:0.5:47.5;
length(time)
plot(time,store)
title('Cell Death Events at Different Seeding Densities')
xlabel('Time(Hours)')
ylabel('Number of DRAQ7 Objects')
legend('3.2x10^4','1.6x10^4','0.8x10^4')