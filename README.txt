/* Adham modification */
added convulution to the bitsGenerator to return the waveform not only the sequence of bits

Data : 14/4/2020

I have changed the bitsGenerator funcation as i need the original sequance of bits in error detection

if you only need the waveform just use [ YourVariable , ~ ] = bitsGenerator ;