function [ pulses , sequencebits ] = bitsGenerator(numberOfBits)

%generate 100 random bits with uniform distirbution (0.5,0.5)
sequencebits = randi([0 1],1,numberOfBits);

%replace every zero with -1 to suit this line coding
for j = 1 : numberOfBits
    if (sequencebits(j) == 0)
        bits(j) = -1;
    else 
        bits(j) = 1;
    end
end

%upsample the bits to convulte it properly
bits = upsample(bits,5);

%create pulse array
pulse = [5 4 3 2 1] / sqrt(55);

%convulte bits with pulse to get final waveform
pulses = conv(bits, pulse);

%cut out the extra 4 bits at the end
%these bits are generated due to the conv and are not wanted
pulses = pulses(1:numberOfBits*5);