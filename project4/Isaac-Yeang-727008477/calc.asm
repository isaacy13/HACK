// ISAAC YEANG : 727008477

// File name: calc.asm

// The program develops a calculator application. 
// The operands a and b are integer numbers stored in RAM[0] (R0) and RAM[1] (R1), respectively.
// The operation choice c is stored in RAM[2] (R2), respectively
// if c == 1, do a + b
// if c == 2, do a - b
// if c == 3, do a * b
// if c == 4, do a / b
// For Addition and Subtraction operations the operands a and b can be positive or negative.
// For Multiplication operation only ONE operand can be negative.
// For Division operation BOTH operands must be positive and must be greater than 0.
// Store the final result (quotient for Division) in RAM[3] (R3). Only the Division operation 
// stores the remainder in RAM[4] (R4).

// if (C-1 == 0) JMP to add
@R2
D=M-1
@add
D ; JEQ

// if (C-2 == 0) JMP to subtract
D=D-1
@subtract
D ; JEQ

// if (C-3 == 0) JMP to multiply
D=D-1
@multiply
D ; JEQ

// if (C-4 == 0) JMP to divide
D=D-1
@divide
D ; JEQ

// if (c == 1)
// ans = a + b
(add)
    @R1
    D=M // D = R1 = b
    @R0
    D=D+M // R1 = R1 + R0

    @R3
    M=D // R3 = R1 = R1 + R0

    @END
    0 ; JMP

// if (c == 2)
// ans = a - b
(subtract)
    @R1
    D=M // D = R1 = b
    @R0
    D=M-D // R1 = R0 - R1

    @R3
    M=D // R3 = R1 = R0 - R1

    @END
    0 ; JMP

// if (c == 3)
// ans = a * b
(multiply)
    // check that only one operand is negative
    // store positive operand in R5
    // store other operand in R6
    // if (a < 0 && b < 0)
    // D = R1 = b
    @R6
    M=0
    @R1
    D=M

    // if (b >= 0) JMP to positiveB
    @positiveB
    D ; JGE

    (negativeB)
        // if positive A, JMP to storePositiveA
        @R0
        D=M
        @storePositiveA
        D ; JGE
    
    // otherwise, continue to RAM[1024] = -1 & EXIT
    (badInput)
        @1024
        M=0
        M=M-1
        @END
        0 ; JMP

    // R5 = a && R6 = b && jump to goodInput
    (storePositiveA)
        @R0
        D=M
        @R5
        M=D

        @R1
        D=M
        @R6
        M=D
        @goodInput
        0; JMP

    // R5 = b && R6 == a
    (positiveB)
        @R1
        D=M // D = b
        @R5 // R5 = b
        M=D

        @R0
        D=M // D = a
        @R6 // R6 = a
        M=D

    // guaranteed to have an R5 && R6
    (goodInput)
        // add R6 to ANS R5 times
        // ans = 0
        @ANS
        M=0
        // count = R5
        @R5
        D=M
        @count
        M=D
        (loopMult)
            @count
            D=M
            // if (count == 0) then JMP to storeANS
            @storeANS
            D ; JEQ

            // otherwise, decrement count, add R6 to ANS, and loop
            @count
            M=M-1

            @R6
            D=M // D=R6

            @ANS
            M=M+D // ANS += R6

            @loopMult
            0 ; JMP


    (storeANS)
        @ANS
        D=M // D = ANS

        // R3 = ANS
        @R3
        M=D
    
    @END
    0 ; JMP

// if (c == 4)
// ans = a / b
// remainder = a - (b * ans)
(divide)
    // check that both operands are positive
    // if (a <= 0 || b <= 0) then bad
    // D = R1 = b
    @R1
    D=M

    // if (b > 0) then JMP to goodInput
    @goodInput
    D ; JGT

    // otherwise RAM[1024] = -1 & EXIT
    (badInput)
        @1024
        M=0
        M=M-1
        @END
        0 ; JMP

    (goodInput)
        // D = R0 = a
        @R0
        D=M

        // if (a <= 0) then JMP to badInput
        @badInput
        D ; JLE

        // otherwise do division operations
        // initialize count=0
        @count
        M=0
        // initialize rem=a
        @R0
        D=M
        @rem
        M=D

        // in case initial loop shouldn't happen
        // if (b - rem  > 0) JMP to storeDivRem
        @R1
        D = M
        @rem
        D = D - M

        @storeDivRem
        D ; JGT
        
        (loopDiv)
            @R1
            D=M
            @rem
            M=M-D // rem -= b

            @count
            M=M+1 // count += 1


            // if (b - rem  > 0) JMP to storeDivRem
            @R1
            D = M
            @rem
            D = D - M

            @storeDivRem
            D ; JGT

            @loopDiv
            0 ; JMP

    (storeDivRem)
        @count
        D = M

        @R3
        M = D

        @rem
        D = M

        @R4
        M = D


(END)
    @END
    0 ; JMP