function outputOfFilter=rectFilter(bits)

%filter of 5 ones after energy normalization
Filter_2=[1 1 1 1 1]/sqrt(5);
outputOfFilter=conv(bits,Filter_2);
outputOfFilter = outputOfFilter (1:10*5);
