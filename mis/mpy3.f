      SUBROUTINE MPY3
C*****
C     PRIMARY DRIVER FOR MATRIX TRIPLE PRODUCT.
C
C     ASSOCIATED SUBROUTINES
C         MPY3DR - SECONDARY DRIVER.  SETS UP OPEN CORE AND DETERMINES
C                  SOLUTION METHOD.
C         MPY3IC - IN-CORE PRODUCT.
C         MPY3OC - OUT-OF-CORE PRODUCT.
C         MPY3A  - PREPARES B AND A(T).
C         MPY3B  - PROCESSES A AND PERFORMS FIRST PART OF PRODUCT.
C         MPY3P  - PERFORMS MULTIPLICATION AND SUMMATION.
C         MPY3NU - CALCULATES NEXT TIME USED FOR INDIVIDUAL COLUMNS OF B
C                  OR ENTRIES OF A.
C         MPY3C  - PERFORMS MULTIPLICATION AND SUMMATION FOR REMAINING
C                  TERMS IN COLUMN OF A.
C
C     DMAP CALLING SEQUENCE
C
C         MPY3     A,B,E / C / C,N,CODE/ C,N,PREC   $
C*****
      INTEGER         FILEA,FILEB,FILEE,FILEC,CODE,PREC, SCR1,SCR2,SCR3
C
C     DMAP PARAMETERS
      COMMON /BLANK / IBCC,IBCP
C     FILES
      COMMON /MPY3TL/ FILEA(7),FILEB(7),FILEE(7),FILEC(7),SCR1,SCR2,
     1                SCR3,LCORE,CODE,PREC,DUMMY(13)
C     OPEN CORE
CZZ   COMMON /ZZMPY3/ Z(1)
      COMMON /ZZZZZZ/ Z(1)
C
C*****
C     ASSIGN GINO FILE NUMBERS.
C*****
      FILEA(1) = 101
      FILEB(1) = 102
      FILEE(1) = 103
      SCR1  = 301
      SCR2  = 302
      SCR3  = 303
      CODE  = IBCC
      PREC  = IBCP
      LCORE = KORSZ(Z)
C*****
C     GET MATRIX TRAILERS
C*****
      CALL RDTRL (FILEA)
      CALL RDTRL (FILEB)
      CALL RDTRL (FILEE)
      IF (FILEE(1) .LT. 0) FILEE(1) = 0
C
      CALL MAKMCB (FILEC,201,FILEA(2),1,PREC)
      IF (CODE .EQ. 0) GO TO 10
      IF (CODE .EQ. 2) FILEC(3) = FILEB(3)
      IF (CODE.EQ.1 .AND. FILEA(2).NE.FILEB(2)) FILEC(4) = 2
      IF (CODE.EQ.2 .AND. FILEB(3).NE.FILEA(2)) FILEC(4) = 2
C*****
C     PERFORM MULTIPLY
C*****
   10 CALL MPY3DR (Z)
      CALL WRTTRL (FILEC)
C
      RETURN
      END
