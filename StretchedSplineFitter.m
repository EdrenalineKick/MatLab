function StretchedSplineFitter()

cd('F:\MicroscopyData\20180123 FUCCI new polyclonal single cells mTeSR vs E8 plus stem beads\');
csvfiles = dir('**\*.csv');

length = zeros(numel(csvfiles),1);
i = 1;
for file = csvfiles'
    table = readtable(file.name);
    length(i) = height(table);
    i = i+1;
end
maxLength = max(length);

totalLength = sum(length)/2;
greenValues = zeros(totalLength,2);
redValues = zeros(totalLength,2);

greenLength = 1;
redLength = 1;
for file = csvfiles'
    table = readtable(file.name);
    %scale time
    timeValues = table2array(table(:,{'Var1'}));
    maxTimeValue = max(timeValues);
    timeValues = (timeValues.*(maxLength/maxTimeValue));
    
    if (contains(file.name,'Green'))
            green = table(:,{'Var1' 'Mean'});
            green.Var1 = timeValues;
            greenArray = table2array(green);
            greenValues(greenLength:(greenLength + height(green)-1),:) = greenArray;
            greenLength = greenLength + height(green);
    elseif (contains(file.name, 'Red'))
            red = table(:,{'Var1' 'Mean'});
            red.Var1 = timeValues;
            redArray = table2array(red);            
            redValues(redLength:(redLength + height(red)-1),:) = redArray;
            redLength = redLength + height(red);
    end
end

greenTime = greenValues(:,1)./2;
redTime = redValues(:,1)./2;

[curve, goodness, output] = fit(greenTime,greenValues(:,2),'smoothingspline','smoothingparam',0.2);
[redCurve, redgoodness, redoutput] = fit(redTime, redValues(:,2),'smoothingspline','smoothingparam',0.2);


figure;
hold on
xlim([0 22])
ylim([100 800])
goodness
redgoodness
plot(redCurve)
plot(curve)
scatter(greenTime,greenValues(:,2),1);
scatter(redTime,redValues(:,2),1);
xlabel('Time');
ylabel('Fluorescence');
ylim([0 1000]);
legend('off');
end