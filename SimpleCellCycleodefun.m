function dydt = SimpleCellCycleodefun(t,y)

if mod(t,10) < 4
    kSK = 1;
else
    kSK = 0;
end

if mod(t,10) > 8
    degEP = 2;
else
    degEP = 0;
end


kSKoff = 0.5;
iSK = 0.1;
degSK = 2;
kEP = 0.05;
jEP = 0.1;
kEnemies = 2;
jEnemies = 0.5;
iCEnemies = 5;
iSEnemies = 0.8;
jiEnemies =0.005;
ienCDK = 0.05;
iepCDK = 2;
jCDK = 0.001;
sCDK = 0.01;
kmCDK = 1;



dSK = kSK - ((kSKoff*y(4)+degSK)*y(1))/(iSK+y(1));
dEP = (kEP*y(4))/(jEP+y(4)) - degEP*y(2);
dEnemies = (kEnemies*y(2))/(jEnemies+y(2))-((iCEnemies*y(4))+(iSEnemies*y(1)))*y(3)/(jiEnemies+y(3));
dCDK = sCDK/(kmCDK + ienCDK*y(3)) - ((iepCDK*y(2)*y(4)))/(jCDK+y(4));


dydt = zeros(4,1);
dydt(1) = dSK;
dydt(2) = dEP;
dydt(3) = dEnemies;
dydt(4) = dCDK;
end


