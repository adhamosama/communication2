function correlatorUsed = correlator(sequence)

pulse = [5 4 3 2 1] / sqrt(55);

repeatPulse = repmat (pulse , 1 , 10);
%multiplication block
afterMul = sequence .* repeatPulse;

afterInt = zeros(1,50);
sum = 0;
%integration and dumd block
for i = 1 : 50
    sum = sum + afterMul(i);
    afterInt(i) = sum;
    if(mod(i,5) == 0)
        sum = 0;
    end
end

correlatorUsed = afterInt;