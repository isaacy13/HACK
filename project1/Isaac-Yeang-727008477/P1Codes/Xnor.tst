//Test Stimulus file for XNor Chip


load Xnor.hdl,
output-file Xnor.out,
compare-to Xnor.cmp,
output-list a%B3.1.3 b%B3.1.3 out%B3.1.3;

// example tst command given
set a 0,
set b 0,
eval,
output;

// now complete the remaining tst commands
set a 0,
set b 1,
eval,
output;

set a 1,
set b 0,
eval,
output;

set a 1,
set b 1,
eval,
output;
