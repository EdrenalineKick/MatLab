function FourierTransformPlot()

cd('F:\MicroscopyData\Sam Waves')
csvfiles = dir('*.csv');

for file = csvfiles'
    table = readtable(file.name);
    
    Fs = 2;            % Sampling frequency                    
    L = height(table);             % Length of signal
    
    X = table(:,8);
    X = table2array(X);
        
    Y = fft(X);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);

    f = Fs*(0:(L/2))/L;
    
    figure;
    [pks,locs] = findpeaks(P1,f);
    findpeaks(P1,f);
    locs = round(locs,3)';
    text(locs,pks,num2str(locs));
    ylim([0 0.2])
    xlim([0 0.4])
    xlabel('Frequency (1/Hours)')
    ylabel('|P1(f)|')
    
%     figure;
%     plot(f,P1) 
%     ylim([0 0.5])
%     title('Single-Sided Amplitude Spectrum of X(t)')
%     xlabel('Fluctuations Per Hour')
%     ylabel('|P1(f)|')
end