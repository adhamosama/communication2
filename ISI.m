clear;clc;
%set filter parameters of fs,fd
fs = 50;
fd = 1;
n = fs/fd;

%create the bits that will pass through the system
numberOfBits = 100;
bits = 2*randi([0 1],1,numberOfBits) -1;

%upsample the bits to match the filter's fs
bits = upsample(bits,fs);


for delay = [ 2 8 ]
    for r = [ 0 1 ]
        
        %create sqrt cosine filter for both transmitter. and receiver
        [num,den] = rcosine(fd,fs,'sqrt',r,delay);
        
        %pass the bits through the trasmitter's filter
        transmitterOutput = filter(num,den,bits);
        
        %show the trasmitter output's eyediagram
        eyediagram(transmitterOutput,n);
        title(['Transmitter Eyediagram at R=',num2str(r),...
               ' and delay =',num2str(delay)]);
           
        %pass the trasmitted waveform through the reciever's filter
        receiverOutput = filter(num,den,transmitterOutput);
        
        %show the receiver's output's eyediagram
        eyediagram(receiverOutput,n);
        title(['Receiver Eyediagram at R=',num2str(r),...
               ' and delay =',num2str(delay)]);
    end
end