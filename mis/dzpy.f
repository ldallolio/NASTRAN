      SUBROUTINE DZPY(KB,KS,LS,I,J1,J2,NYFLAG,          SGR,CGR,
     *   FMACH,ARB,NBEA,DT)
C   ***   GENERATES ROWS OF THE SUBMATRICES  DZP, DZZ  AND  DZY
C         USING  SUBROUTINE  SUBB
      COMPLEX SUM,DT(1)
      DIMENSION ARB(1),NBEA(1)
      COMMON /DLBDY/ NJ1,NK1,NP,NB,NTP,NBZ,NBY,NTZ,NTY,NT0,NTZS,NTYS,
     *   INC,INS,INB,INAS,IZIN,IYIN,INBEA1,INBEA2,INSBEA,IZB,IYB,
     *   IAVR,IARB,INFL,IXLE,IXTE,INT121,INT122,IZS,IYS,ICS,IEE,ISG,
     *   ICG,IXIJ,IX,IDELX,IXIC,IXLAM,IA0,IXIS1,IXIS2,IA0P,IRIA
     *  ,INASB,IFLA1,IFLA2,ITH1A,ITH2A,
     *   ECORE,NEXT,SCR1,SCR2,SCR3,SCR4,SCR5
CZZ   COMMON /ZZDAMB / Z(1)
      COMMON /ZZZZZZ / Z(1)
      NDY  = 0
      NYFL = NYFLAG
      PI   = 3.1415926
      EPS  = 0.00001
      BETA = SQRT(1.0-FMACH**2)
      JZ   = 0
      LB   = 1
      JB   = 0
      AR   = ARB(LB)
C  LS IS THE INDEX OF THE  Y  AND  Z  COORDINATES OF SENDING POINT  J --
C  LS RUNS FROM NSTRIP+1  THROUGH  NSTRIP+NBZ
      DO  30  J=J1,J2
      JB   = JB+1
C  JB  IS THE BODY-ELEMENT NUMBER IN BODY  LB  --  JB  RUNS FROM  1
C  THROUGH  NTZ
      JZ   = JZ+1
C  JZ  RUNS FROM 1  THROUGH  NBE-SUB-LB
      CALL SUBB(KB,KS,I,J,JB,LB,LS,NDY,NYFL,          PI,EPS,
     *   SGR,CGR,AR,BETA,SUM,Z(IRIA),Z(IDELX),Z(IYB),Z(IZB),Z(IYS),
     *  Z(IZS),Z(IX))
      DT(J)= SUM
      IF  (JZ.EQ.NBEA(LB))    GO TO  20
      GO TO 30
   20 CONTINUE
      JZ   = 0
      LB   = LB+1
      LS   = LS+1
      AR   = ARB(LB)
   30 CONTINUE
      RETURN
      END
