      SUBROUTINE MELBOW
C
C     THIS ROUTINE COMPUTES THE MASS MATRIX M(NPVT,NPVT) FOR AN ELBOW.
C
C     ECPT FOR THE ELBOW
C
C     ECPT( 1)  -  IELID        ELEMENT ID. NUMBER
C     ECPT( 2)  -  ISILNO(2)    * SCALAR INDEX NOS. OF THE GRID POINTS
C     ECPT( 3)  -    ...        *
C     ECPT( 9)  -  A            CROSS-SECTIONAL AREA
C     ECPT(13)  -  NSM          NON-STRUCTURAL MASS
C     ECPT(29)  -  R            RADIUS OF CURVATURE
C     ECPT(30)  -  BETAR        ANGLE FROM GA TO GB
C
      LOGICAL          HEAT
      INTEGER          IZ(1),EOR,CLSRW,CLSNRW,FROWIC,TNROWS,OUTRW,BGGIND
      REAL             NSM
      DOUBLE PRECISION TA(9),TB(9),DP(6),VECI(3),DELA(6),DELB(6),FL,
     1                 M(36),DUMDP,FM
      DIMENSION        ECPT(9),IECPT(1)
      COMMON /SMA2HT/  HEAT
      COMMON /SMA2IO/  IFCSTM,IFMPT,IFDIT,IDUM1,IFECPT,IGECPT,IFGPCT,
     1                 IGGPCT,IDUM2,IDUM3,IFMGG,IGMGG,IFBGG,IGBGG,
     2                 IDUM4,IDUM5,INRW,OUTRW,CLSNRW,CLSRW,NEOR,EOR,
     3                 MCBMGG(7),MCBBGG(7)
CZZ   COMMON /ZZSMA2/  Z(1)
      COMMON /ZZZZZZ/  Z(1)
C
C     SMA2 VARIABLE CORE BOOKKEEPING PARAMETERS
C
      COMMON /SMA2BK/  ICSTM,NCSTM,IGPCT,NGPCT,IPOINT,NPOINT,I6X6M,
     1                 N6X6M,I6X6B,N6X6B
C
C     SMA2 PROGRAM CONTROL PARAMETERS
C
      COMMON /SMA2CL/  IOPT4,BGGIND,NPVT,LEFT,FROWIC,LROWIC,NROWSC,
     1                 TNROWS,JMAX,NLINKS,LINK(10),NOGO
C
C     ECPT COMMON BLOCK
C
      COMMON /SMA2ET/  IELID,ISILNO(2),SMALLV(3),ICSSV,IMATID,A,I1,I2,
     1                 FJ,NSM,FE,DUM(14),R,BETAR,DUMM(8),TEMPEL
C
C     SMA2 LOCAL VARIABLES
C
      COMMON /SMA2DP/  TA,TB,DP,VECI,DELA,DELB,FL,M,DUMDP
C
C     INPUT AND OUTPUT BLOCKS FOR SUBROUTINE MAT
C
      COMMON /MATIN /  MATIDC,MATFLG,ELTEMP,STRESS,SINTH,COSTH
      COMMON /HMTOUT/  CP
      COMMON /MATOUT/  RHO,PROP(8)
      EQUIVALENCE      (Z(1),IZ(1),DZ),(ECPT(1),IECPT(1),IELID)
      DATA    DCR   /  0.01745329/
C
C     COMPUTE LENGTH OF ELBOW, FL
C
      DP(1) = R
      DP(2) = BETAR
      DP(3) = DCR
      FL    = DP(1)*DP(2)*DP(3)
      IF (FL .EQ. 0.0D0) GO TO 200
      IF (HEAT) GO TO 300
C
C     GET RHO FROM MPT BY CALLING MAT
C
      MATIDC = IMATID
      MATFLG = 4
      ELTEMP = TEMPEL
      CALL MAT (ECPT(1))
      DO 40 I = 1,36
   40 M(I) = 0.0D0
      FM = 0.5*FL*(RHO*A + NSM)
C
C     PUT MASS IN M-ARRAY
C
      M(1)  = FM
      M(8)  = M(1)
      M(15) = M(1)
C
C     INSERT THE 6 X 6
C
      CALL SMA2B (M,NPVT,-1,IFMGG,DUMDP)
      RETURN
C
  200 CALL MESAGE (30,26,IECPT(1))
C
C     SET FLAG FOR FATAL ERROR WHILE ALLOWING ERROR MESSAGES TO
C     ACCUMULATE
C
      NOGO = 1
      RETURN
C
C     HEAT FORMULATION
C
C     GET CP USING -HMAT- ROUTINE.
C
  300 MATIDC = IMATID
      MATFLG = 4
      CALL HMAT (IELID)
      M(1) = FL*DBLE(ECPT(9))*DBLE(CP)/2.0D0
C
C     OUTPUT THE MASS FOR HEAT PROBLEM.
C
      CALL SMA2B (M(1),NPVT,NPVT,IFBGG,DUMDP)
      RETURN
      END
