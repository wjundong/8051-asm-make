;===========================================================================

;-----------------------------------------------------
;    sy3_2.asm
;        the P1 port exam
;------------------------------------------------------

    .module sy3_2
    .globl start
    .globl P1_3
    .globl P1_2
    .area RSEG (ABS,DATA)
    .org 0x0000
    P1_3 = 0x0093
    P1_2 = 0x0092
    .area HOME (ABS,CODE)
    .org 0x0000
    sjmp start
    .org 0x0030
start:
    setb P1_3
IF1:
    jnb P1_3,ELSE1
THEN1:
    clr P1_2
    sjmp ENDIF1
ELSE1:   
    setb P1_2
ENDIF1:
    sjmp start
    sjmp foo

;=======================================================================
