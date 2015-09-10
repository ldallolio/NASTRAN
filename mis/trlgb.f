      SUBROUTINE TRLGB (USETD,AP,GMD,GOD,PHIDH,AS,AD,AH,IFLAG1,SCR1,
     1                  SCR2,SCR3,SCR4)
C
C     THE PURPOSE OF THIS ROUTINE IS TO REDUCE THE SCALE FACTOR MATRIX
C     AP TO  A TRANS FORMATION MATRIX  AS, AD, AH
C
C     INPUTS (5)
C         USETD
C         AP     SCALE MATRIX --P SIZE
C         GMD    M- SET TRASNFORMATION MATRIX
C         GOD    0- SET TRASNFORMATION MATRIX
C         PHIDH  H- SET TRASNFORMATION MATRIX
C
C     OUTPUTS(3)
C         AS     SCALE MATRIX --S SET
C         AD     SCALE MATRIX --D SET
C         AH     SCALE MATRIX --H SET
C
C     NOTE  IFLAG1 WILL BE SET  TO -1  IF  AP = AD (N0 M,S,O)
C
C
      EXTERNAL        ANDF
      INTEGER         USETD,AP,GMD,GOD,PHIDH,AS,AD,AH,MCB(7),SCR1,
     1                USET1,ANBAR,AM,AN,AF,ADBAR,AO,ANDF,MULTI,SINGLE,
     2                OMIT,SIGN,TRNSP,PREC,SCR2,SCR3,SCR4,UM,US,UO
      COMMON /BITPOS/ UM,UO,UR,USG,USB,UL,UA,UF,US,UN,UG,UE,UP,UNE,UFE,
     1                UD
CZZ   COMMON /ZZSSA2/ IZ(1)
      COMMON /ZZZZZZ/ IZ(1)
      COMMON /SYSTEM/ ISKIP(54),IPREC
      COMMON /PATX  / NZ,N1,N2,N3,USET1
      COMMON /TWO   / TWO1(32)
C
C
      ANBAR = SCR2
      AM    = SCR3
      AN    = SCR4
      AF    = SCR2
      ADBAR = SCR3
      AO    = SCR4
C
C     SET FLAGS FOR PRESCENCE OF SETS
C
      MCB(1) = USETD
      CALL RDTRL (MCB)
      USET1  = USETD
      MULTI  = ANDF(MCB(5),TWO1(UM))
      SINGLE = ANDF(MCB(5),TWO1(US))
      OMIT   = ANDF(MCB(5),TWO1(UO))
      MODAL  = 0
      MCB(1) = PHIDH
      CALL RDTRL (MCB)
      IF (MCB(1) .LE. 0) MODAL = 1
      NZ     = KORSZ(IZ)
      SIGN   = 1
      TRNSP  = 1
      PREC   = IPREC
C
C     REMOVE EACH CONSTRAINT
C
      IF (MULTI .EQ. 0) GO TO 10
      IF (SINGLE.EQ.0 .AND. OMIT.EQ.0) AN = AD
      CALL CALCV (SCR1,UP,UNE,UM,IZ)
      CALL SSG2A (AP,ANBAR,AM,SCR1)
      CALL SSG2B (GMD,AM,ANBAR,AN,TRNSP,PREC,SIGN,SCR1)
      GO TO 20
C
C     NO MULTI-POINT CONSTRAINTS
C
   10 AN = AP
C
C     REMOVE SINGLES
C
   20 IF (SINGLE .EQ. 0) GO TO 30
      IF (OMIT  .EQ.  0) AF = AD
      CALL CALCV (SCR1,UNE,UFE,US,IZ)
      CALL SSG2A (AN,AF,AS,SCR1)
      GO TO 40
C
C     NO SINGLES
C
   30 AF = AN
   40 IF (OMIT .EQ. 0) GO TO 50
C
C     REMOVE OMITS
C
      CALL CALCV (SCR1,UFE,UD,UO,IZ)
      IF (AF .EQ. AO) AO = SCR2
      CALL SSG2A (AF,ADBAR,AO,SCR1)
      CALL SSG2B (GOD,AO,ADBAR,AD,TRNSP,PREC,SIGN,SCR1)
      GO TO 60
C
C     NO OMITS
C
   50 AD = AF
C
C     REMOVE TO H SET
C
   60 IF (MODAL .NE. 0) GO TO 70
      CALL SSG2B (PHIDH,AD,0,AH,TRNSP,PREC,SIGN,SCR1)
   70 IFLAG1 = MULTI + SINGLE + OMIT
      IF (IFLAG1 .EQ. 0) IFLAG1 = -1
      RETURN
      END
