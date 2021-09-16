// ISAAC YEANG : 727008477

// File name: aggie.asm

// The program runs an infinite loop that listens to the keyboard input. As soon as a 
// key press is detected, the program exits the wait loop and proceeds to draw the 
// graphic as described in the project document. 
// You will need to draw the triangles pixel by pixel because HACK asm has no 
// utilities for drawing shapes.
// State any assumptions made in your program 

// Assumptions (as applicable)

// KBD = 0
@KBD
M=0 // corresponds to null

(LOOP)
    @KBD
    D=M
    @DRAWTOPTRIANGLE
    D ; JNE // if KBD != 0 JMP to DRAW

    @LOOP // otherwise, loop
    0 ; JMP


(DRAWTOPTRIANGLE)
    // init row = 0
    @row
    M=0
    // init factor = -1
    @factor
    M=0
    M=M-1 // factor = -1
    // init regskip
    @regskip
    M=0
    (FL1)
        @row
        D=M
        @128
        D=D-A
        @DRAWBOTTOMTRIANGLE
        D ; JGE // if(row-128 >= 0) JMP DRAWBOTTOMTRIANGLE
        // init col = 0
        @col
        M=0
            
        (FL2)
            @col
            D=M
            @16
            D=D-A
            @regskip
            D=D+M
            @FL1NEXT
            D ; JGE // if (col + regskip - 16 >= 0) JMP to FL1NEXT

            // row * 32
            @countMULT
            M=0

            // init ans = 0
            @multANS
            M=0

            (mult)
                @countMULT
                D=M
                @32
                D=D-A
                
                @FL2NEXT
                D ; JEQ // if (countMULT-32 == 0) JMP to FL2NEXT
                
                @countMULT
                M=M+1 // countMULT++

                @row
                D=M
                @multANS
                M=M+D // ANS += row

                @mult
                0 ; JMP // loop

            (FL2NEXT)
                @col
                D=M
                @15
                D=D-A
                @regskip
                D=D+M
                @ISEND
                D ; JEQ // if (col-15+regskip == 0) JMP to ISEND

            (NOTEND)
                @16384
                D=A
                @multANS
                D=D+M
                @col
                D=D+M // D = 16384+32*row+col

                @index
                M=D
                @0
                D=A-1 // D =-1

                @index
                A=M
                M=D // RAM[index] = -1
                @AFTEREND
                0 ; JMP
            (ISEND)
                @16384
                D=A
                @multANS
                D=D+M
                @col
                D=D+M // D = 16384+32*row+col

                @index
                M=D
                @factor
                D=M
                @index
                A=M
                M=D // RAM[index] = factor
            
            (AFTEREND)
            @col
            M=M+1 // col++
            @FL2
            0 ; JMP // loop

    (FL1NEXT)
        @factor
        D=M
        D=D+1 // D=factor+1
        @SETFACTORLARGE
        D ; JEQ // if (factor+1 == 0) JMP to SETFACTORLARGE

        @4
        D=D-A // D=factor-3
        @SETFACTORNEGONE
        D ; JEQ // if (factor-3 == 0) JMP to SETFACTORNEGONE

    (FACTORDIVFOUR) // factor /= 4
        @countDIV4 //init count = 0
        M=0
        @factor
        D=M
        @remDIVFOUR // init rem = factor
        M=D
        (DIVFOURLOOP)
            @4
            D=A
            @remDIVFOUR
            D=D-M
            @DIVFOURLOOPDONE // WHEN DONE, JMP DIVFOURLOOPDONE
            D ; JGT

            @4
            D=A
            @remDIVFOUR
            M=M-D // rem -= b

            @countDIV4
            M=M+1

            @DIVFOURLOOP
            0 ; JMP // loop
        (DIVFOURLOOPDONE)
            @countDIV4
            D=M
            @factor
            M=D //factor = countDIV4
            @FL1INCLOOP // WHEN DONE, JMP INCLOOP
            0 ; JMP

    (SETFACTORLARGE)
        @16383
        D=A
        @factor
        M=D // factor = 16383
        @FL1INCLOOP
        0 ; JMP
    (SETFACTORNEGONE)
        @factor
        M=0
        M=M-1 // factor = -1
        @regskip
        M=M+1

    (FL1INCLOOP)
    @row
    M=M+1 // row++
    @FL1
    0 ; JMP


(DRAWBOTTOMTRIANGLE)
    @128
    D=A
    @row // init row = 128
    M=D
    // init factor = -16384
    @16384
    D=-A
    @factor
    M=D
    // init regskip = 15
    @15
    D=A
    @regskip
    M=D // regskip = 15
    (bFL1)
        @row
        D=M
        @256
        D=D-A
        @END
        D ; JGE // if(row-256 >= 0) JMP END
        // init col = 16 + regskip
        @16
        D=A
        @regskip
        D=D+M
        @col
        M=D // col = 16 + regskip
            
        (bFL2)
            @col
            D=M
            @32
            D=D-A // D = col-32
            @bFL1NEXT
            D ; JGE // if (col - 32 >= 0) JMP to bFL1NEXT

            // row * 32
            @countMULT
            M=0

            // init ans = 0
            @multANS
            M=0

            (bmult)
                @countMULT
                D=M
                @32
                D=D-A
                
                @bFL2NEXT
                D ; JEQ // if (countMULT-32 == 0) JMP to FL2NEXT
                
                @countMULT
                M=M+1 // countMULT++

                @row
                D=M
                @multANS
                M=M+D // ANS += row

                @bmult
                0 ; JMP // loop

            (bFL2NEXT)
                @col
                D=M
                @16
                D=D-A
                @regskip
                D=D-M
                @bISEND
                D ; JEQ // if (col-16-regskip == 0) JMP to bISEND

            (bNOTEND)
                @16384
                D=A
                @multANS
                D=D+M
                @col
                D=D+M // D = 16384+32*row+col

                @index
                M=D
                @0
                D=A-1 // D =-1

                @index
                A=M
                M=D // RAM[index] = -1
                @bAFTEREND
                0 ; JMP

            (bISEND)
                @16384
                D=A
                @multANS
                D=D+M
                @col
                D=D+M // D = 16384+32*row+col

                @index
                M=D
                @factor
                D=M
                @index
                A=M
                M=D // RAM[index] = factor
            
            (bAFTEREND)
            @col
            M=M+1 // col++
            @bFL2
            0 ; JMP // loop

    (bFL1NEXT)
        @factor
        D=M
        @1
        D=D+A // D=factor+1
        @bSETFACTORNEGONE
        D ; JEQ // if (factor+1 == 0) JMP to bSETFACTORNEGONE

    // otherwise, factor /= 4
    (bFACTORDIVFOUR) // factor /= 4
        @countDIV4 //init count = 0
        M=0
        @factor
        D=-M // negatize to divide
        @remDIVFOUR // init rem = factor
        M=D
        (bDIVFOURLOOP)
            @4
            D=A
            @remDIVFOUR
            D=D-M
            @bDIVFOURLOOPDONE // WHEN DONE, JMP DIVFOURLOOPDONE
            D ; JGT

            @4
            D=A
            @remDIVFOUR
            M=M-D // rem -= b

            @countDIV4
            M=M+1

            @bDIVFOURLOOP
            0 ; JMP // loop

        (bDIVFOURLOOPDONE)
            @countDIV4
            D=M
            @factor
            M=-D //factor = -countDIV4 (renegatize)
            @bFL1INCLOOP // WHEN DONE, JMP INCLOOP
            0 ; JMP

    (bSETFACTORNEGONE)
        @16384
        D=-A
        @factor
        M=D // factor = -16384
        @regskip
        M=M-1

    (bFL1INCLOOP)
    @row
    M=M+1 // row++
    @bFL1
    0 ; JMP

(END)
    @END
    0 ; JMP