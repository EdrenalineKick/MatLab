function dydt = ModelScenariosodefun(t,y)

persistent lastAPC lastCDK currentAPC currentCDK dnaSynthT mitosisT divisionT kais kaim cellSize

if t == 0
    kais = 0;
    lastAPC = y(2);
    lastCDK = y(1);
    currentAPC = y(2);
    currentCDK = y(1);
    dnaSynthT = -100;
    mitosisT = -100;
    cellSize = 1;
    divisionT = -100;
end
lastAPC = currentAPC;
lastCDK = currentCDK;
currentAPC = y(2);
currentCDK = y(1);

if lastAPC > 0.2 && currentAPC <= 0.2 
    dnaSynthT = t;
    kais = 3;
end

if t-dnaSynthT < 5
    kais = 3 - 0.6*(t-dnaSynthT);
end

u = 0.005;
kai = kaim + kais;
k1 = 0.05;
k2a = 0.05;
k2b = 1;
k3a = 0.1;
k3b = 3;
k4a = 0;
k4b = 2;
kas = 0.05;
kada = 0.005;
kadb = 1;
kaa = 1;
j3 = 0.05;
j4 = 0.05;

if (lastAPC < 0.2 && currentAPC >= 0.2 && abs(t - divisionT) > 2)
    cellSize
    cellSize = cellSize/2;
    divisionT = t;
    cellSize
else
    cellSize = cellSize + u*cellSize;
end


dCDK = k1*cellSize - (k2a*(1-y(2))+k2b*y(2)*y(1));
dAPC = (((k3a+k3b*y(4))*(1-y(2)))/(j3+1-y(2))) - ((k4a+k4b*y(1))*y(2))/(j4+y(2));
dACTt = kas - (kada*(1-y(2))+kadb*y(2))*y(3);
dACT = kaa*(y(3)-y(4))-kai*y(4)-(kada*(1-y(2))+kadb*y(2))*y(4);

dydt = zeros(4,1);
dydt(1) = dCDK;
dydt(2) = dAPC;
dydt(3) = dACTt;
dydt(4) = dACT;
end