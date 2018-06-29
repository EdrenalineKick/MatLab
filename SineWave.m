function SineWave()
time = 0 : 0.01 : 2*pi;
fucci_phase = (sin(2*pi*time)+0.5);
fucci_green = fucci_phase;
fucci_green(fucci_green < 0) = 0;
fucci_red = fucci_phase;
fucci_red(fucci_red >= 0) = 0;
hold on;
plot(time,fucci_green,'g');
plot(time,fucci_red, 'r');
refline([0 0]);