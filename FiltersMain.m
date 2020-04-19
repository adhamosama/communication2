[sequence,bits] = bitsGenerator(10);
x = correlator(sequence);
y = matchedFilter(sequence);
z = rectFilter(sequence);

figure (1)
title ('Matched Filter vs Rect Filter')
xlabel ('bits')
ylabel ('amplitude')
hold on
plot (y , 'red')
plot (z , 'blue')
legend ('Matched Filter' , 'Rect Filter')
grid on
hold off
figure (2)
title ('Matched Filter vs Correlator')
xlabel ('bits')
ylabel ('amplitude')
hold on
plot (y , 'red')
plot (x , 'blue')
legend ('Matched Filter' , 'Correlator')
hold off