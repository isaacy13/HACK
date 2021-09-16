//Starter Test Stimulus for LeftLogicBitshift chip

load LeftLogicBitshift.hdl,
output-file LeftLogicBitshift.out,
compare-to LeftLogicBitshift.cmp,
output-list x%B1.16.1 y%B1.4.1 out%B1.16.1;

set x %B0000000010101011,
set y %B0001,
eval,
output;

set x %B1111111111111111,
set y %B1000,
eval,
output;

set x %B1111111111111111,
set y %B0000,
eval,
output;

//write more tst commands and also complete the .cmp file 

set x %B1111111111111111,
set y %B0010,
eval,
output;

set x %B1111111111111111,
set y %B0011,
eval,
output;

set x %B1111111111111111,
set y %B0100,
eval,
output;

set x %B1111111111111111,
set y %B0101,
eval,
output;

set x %B1111111111111111,
set y %B0110,
eval,
output;

set x %B1111111111111111,
set y %B0111,
eval,
output;

set x %B1111111111111111,
set y %B1000,
eval,
output;

set x %B1111111111111111,
set y %B1001,
eval,
output;

set x %B1111111111111111,
set y %B1010,
eval,
output;

set x %B1111111111111111,
set y %B1011,
eval,
output;

set x %B1111111111111111,
set y %B1100,
eval,
output;

set x %B1111111111111111,
set y %B1101,
eval,
output;

set x %B1111111111111111,
set y %B1110,
eval,
output;

set x %B1111111111111111,
set y %B1111,
eval,
output;