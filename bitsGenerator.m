function bits = bitsGenerator(numberOfBits)

%generate 100 random bits with uniform distirbution (0.5,0.5)
bits = randi([0 1],1,numberOfBits);

%replace every zero with -1 to suit this line coding
for j = 1 : numberOfBits
    if (bits(j) == 0)
        bits(j) = -1;
    end
end

%upsample the bits to convulte it properly
bits = upsample(bits,4);