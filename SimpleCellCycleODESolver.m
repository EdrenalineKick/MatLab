function SimpleCellCycleODESolver()
clear ModelScenariosodefun

[t,y] = ode45(@ModelScenariosodefun3,0:0.01:200,[0.15;0.4;0.2;0.1;1]);

figure;
subplot(2,2,1)
plot(t,y(:,1),'-o')
title('CDK')

subplot(2,2,2)
plot(t,y(:,2),'-o')
title('APC')

subplot(2,2,3)
plot(t,y(:,3),'-o')
title('ACTt')

subplot(2,2,4)
plot(t,y(:,4),'-o')
title('ACT')

figure;
hold on
plot(t,y(:,1))
plot(t,y(:,2))
plot(t,y(:,3))
plot(t,y(:,4))
plot(t,y(:,5))
end