//Test Stimulus file for PriorityEncoder83 Chip

load PriorityEncoder83.hdl,
output-file PriorityEncoder83.out,
compare-to PriorityEncoder83.cmp,
output-list a%B2.8.2 out%B2.3.2 idle%B2.1.2;


set a %B10000000,
eval,
output;

// Build more testcases below to fully test the functionality
set a %B11111111,
eval,
output;

set a %B01000000,
eval,
output;

set a %B01111111,
eval,
output;

set a %B01110111,
eval,
output;

set a %B01101001,
eval,
output;

set a %B00100000,
eval,
output;

set a %B00010000,
eval,
output;

set a %B00001000,
eval,
output;

set a %B00000100,
eval,
output;

set a %B00000010,
eval,
output;

set a %B00000001,
eval,
output;

set a %B00000000,
eval,
output;