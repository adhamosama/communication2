
%% generate Transmitted Signal 

% generate a sequence of 10000 bits represent the transmited signal 
[ TransmittedSignal , SequenceOfBits ]  =  bitsGenerator(10000) ; 

% assume ideal channel 
Channel =  1 ;

%% generate White noise 

% generate additive white gaussien noise with unity varience and zero mean 
generatedNoise =  randn ( [1 length(TransmittedSignal) ] ) ;

SNR = [-2:1:5] ; %% Eb/N0 form -2dB to 5 dB
N0 = 1 ./ (10.^(SNR/10)) ; %% fundemental power (watt/freq) = 10 ^ (SNR/10) 
AWGNVariance = N0 .* 0.5 ; %% AWGN Variance 
 
%% Matched filter Transfer function

MatchedFilter = [5 4 3 2 1] / sqrt(55) ; % generate the same 
MatchedFilter = fliplr(MatchedFilter) ; %flip the pulse as choose Ts = Tm

%% Square Filter Transfer function

SquareFilter = [ 5 5 5 5 5 ] / sqrt(125) ; %generate squre filter with unity energy same as pulse

%% generate recieved signals at filter

for i = 1 : length(N0)
    
     MatchedCorrectBits = 0 ; % hold number of correct recieved signals using matching filter
     SquareCorrectBits  = 0 ; % hold number of correct recieved signals using square filter
    
    %% scalling to change the variance to N0/2
    NoiseSignal = generatedNoise * sqrt(AWGNVariance(i)) ;
    
    % Recieved signal at input of the filter = Transmitted signal + Noise 
    FilterInput = TransmittedSignal + NoiseSignal ;
    
    % Output signals at each filter 
    MatchedFilterOutput = conv(FilterInput,MatchedFilter) ; %output of matched filter 
    SquareFilterOutput  = conv(FilterInput,SquareFilter)  ; %output of square filter
    
    %% sampling with Ts (every 5 samples )
    for k = 1 : length(SequenceOfBits)
       %% bit detection A > 0 -> 1 , A < 0 -> 0 
       
       % bit detection for matched filter  
       if  ( MatchedFilterOutput(k*5) > 0 ) % if the sample higher than zero 
           SampledMatchedFilterOutput(k) = 1 ; % assign recieved bit as One
       else % if not
           SampledMatchedFilterOutput(k) = 0 ; % assign recieved bit as Zero
       end
       % detection of error bits in recieved bits
       if  ( SampledMatchedFilterOutput(k) == SequenceOfBits (k) )  % if the bit is the same as original sequence
           MatchedCorrectBits = MatchedCorrectBits + 1 ; % increment the number of correct bits
       end
       
       % bit detection for square filter  
       if  ( SquareFilterOutput(k*5) > 0 )  % if the sample higher than zero
           SampledSquareFilterOutput(k) = 1 ; % assign recieved bit as One
       else % if not
           SampledSquareFilterOutput(k) = 0 ; % assign recieved bit as Zero
       end
       % detection of error bits in recieved bits
       if  ( SampledSquareFilterOutput(k) == SequenceOfBits (k) ) % if the bit is the same as original sequence
           SquareCorrectBits = SquareCorrectBits + 1 ;% increment the number of correct bits
       end
       
    end
    % calculate the error for each SNR 
    MatchedError (i) = 1 - ( MatchedCorrectBits / length(SequenceOfBits) ) ; % matched error 
    SquareError  (i) = 1 - ( SquareCorrectBits  / length(SequenceOfBits) ) ; % square error
    
    % calculate the theoretical BER using erfc function for each SNR
    BERTheoretically (i) = 0.5 * erfc ( sqrt(1/N0(i)) ) ;  
    
end

%% plot the results

figure ; 
title(' Probabilty of Error ');
xlabel(' SNR '); % plot the probabilty of error verses SNR of the recieved signal
ylabel(' BER ') ;
hold on ;
plot( SNR , MatchedError , 'red' ) ; % plot the error probabilty in case of using matched filter
plot( SNR , SquareError , 'blue' ) ; % plot the error probabilty in case of using square filter
plot( SNR, BERTheoretically , 'green' ) ; % plot the therotical BER
legend( 'Matched Error' , 'Square Error' , 'Theoretical BER' ) ;
grid on 

%% 


