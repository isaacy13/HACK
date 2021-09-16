// ISAAC YEANG : 727008477

// File name: palin.asm

// The program develops a Palindrome checker application. 
// The input to the program is a 5 digit integer A and is stored in RAM[0] (R0).
// A helper value of 10 is stored in RAM[8] (R8) by virtue of the tst file command.
// Number A is a positive integer.
// A has exactly 5 digits and no more no less.

// Program functions as follows: 
// Extract the individual digits from number A and store them in R2-R6 registers in that order.
// Result of 1 is stored in R1 if the number A is a Palindrome else result of 0 is stored in R1

// initialize count to 5
@5
D=A
@count
M=D

// while loop
(LOOP)
    // IF (COUNT == 0) JMP to PALINCHECK
    @count
    D=M
    @PALINCHECK
    D ; JEQ

    (mod) // D = RAM[0] % 10
        // a = R0
        // b = R8 = 10
        // initialize rem = a
        @R0
        D=M
        @rem
        M=D // rem = a
        (LOOPmod)
            // if (b-rem > 0) JMP to SAVE
            @R8
            D=M
            @rem
            D=D-M
            @SAVE
            D ; JGT

            // otherwise...
            @R8
            D=M
            @rem // rem -= b
            M=M-D

            @LOOPmod
            0 ; JMP

            (SAVE) // RAM[X] = D & JMP to DECDIV
                // IF (COUNT-5 == 0) RAM[2] = RAM[0] % 10;
                @count
                D=M
                @5
                D=D-A
                @saveR2
                D ; JEQ

                // IF (COUNT-4 == 0) RAM[3] = RAM[0] % 10;
                @count
                D=M
                @4
                D=D-A
                @saveR3
                D ; JEQ

                // IF (COUNT-3 == 0) RAM[4] = RAM[0] % 10;
                @count
                D=M
                @3
                D=D-A
                @saveR4
                D ; JEQ

                // IF (COUNT-2 == 0) RAM[5] = RAM[0] % 10;
                @count
                D=M
                @2
                D=D-A
                @saveR5
                D ; JEQ

                // IF (COUNT-1 == 0) RAM[6] = RAM[0] % 10;
                @count
                D=M
                @1
                D=D-A
                @saveR6
                D ; JEQ

                (saveR2)
                    @rem
                    D=M
                    @R2
                    M=D
                    @DECDIV
                    0 ; JMP

                (saveR3)
                    @rem
                    D=M
                    @R3
                    M=D
                    @DECDIV
                    0 ; JMP

                (saveR4)
                    @rem
                    D=M
                    @R4
                    M=D
                    @DECDIV
                    0 ; JMP

                (saveR5)
                    @rem
                    D=M
                    @R5
                    M=D
                    @DECDIV
                    0 ; JMP

                (saveR6)
                    @rem
                    D=M
                    @R6
                    M=D
                    @DECDIV
                    0 ; JMP

    // decrement, divide, and loop
    (DECDIV)
        @count
        M=M-1 // count--

        // a = R0
        // b = R8 = 10
        // initialize rem = a, count = 0
        @R0
        D=M
        @rem
        M=D // rem = a
        @countDECDIV
        M=0
        (LOOPdecdiv)
            // if (b-rem > 0) JMP to SAVEdecdiv
            @R8
            D=M
            @rem
            D=D-M
            @SAVEdecdiv
            D ; JGT

            // otherwise...
            @R8
            D=M
            @rem // rem -= b
            M=M-D

            @countDECDIV // countDECDIV++
            M=M+1

            @LOOPdecdiv
            0 ; JMP

        (SAVEdecdiv)
            @countDECDIV
            D=M
            @R0
            M=D // a = a/10
            @LOOP
            0 ; JMP

(PALINCHECK)
    // if (R2 - R6 == 0 && R3 - R5 == 0) R1 = 1
    (check1)
        @R2
        D=M
        @R6
        D=D-M
        @failed
        D ; JNE // if R2-R6 != 0 JMP to failed
    (check2)
        @R3
        D=M
        @R5
        D=D-M
        @failed
        D ; JNE // if R3-R5 != 0 JMP to failed
    
    // otherwise R1=1, JMP to end
    @R1
    M=1
    @END
    0 ; JMP
    
    // else R1 = 0
    (failed)
        @R1
        M=0

(END)
    @END
    0 ; JMP