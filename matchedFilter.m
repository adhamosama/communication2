function matchedFilterUsed = matchedFilter(sequence)


%creating a pulse
pulse = [5 4 3 2 1] / sqrt(55);

%create the matching filter
matchedFilter = fliplr (pulse);

%convolve the sequence with matched filter to produce 
%the decision making signal
matchedFilterUsed = conv (sequence , matchedFilter);
matchedFilterUsed = matchedFilterUsed(1:10*5);