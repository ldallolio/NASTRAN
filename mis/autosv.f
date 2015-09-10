      SUBROUTINE AUTOSV
C
C     THIS ROUTINE GENERATES OSCAR ENTRIES FOR PARAMTERS
C     THAT ARE TO BE SAVED IMPLICITLY
C
      EXTERNAL         LSHIFT,ANDF
      INTEGER          SAVNAM,OSPRC,OSBOT,OSPNT,OSCAR(1),OS(5),XSAV(2),
     1                 DMPCNT,ANDF,VPS
      COMMON  /XGPIC / JUNK(25),MASKHI,JUNK1(2),NOSGN
      COMMON  /AUTOSM/ NWORDS,SAVNAM(100)
CZZ   COMMON  /ZZXGPI/ CORE(1)
      COMMON  /ZZZZZZ/ CORE(1)
      COMMON  /XVPS  / VPS(1)
      COMMON  /XGPI4 / JUNK4(2),ISEQN,DMPCNT
      COMMON  /AUTOHD/ IHEAD
      EQUIVALENCE      (CORE(1),OS(1),LOSCAR), (OS(2),OSPRC),
     1                 (OS(3),OSBOT), (OS(4),OSPNT), (OS(5),OSCAR(1))
      DATA     XSAV  / 4HXSAV,4HE    /
C
C     UPDATE OSCAR PARAMETERS
C
      IHEAD = 1
      OSPRC = OSBOT
      OSBOT = OSCAR(OSBOT) + OSBOT
      OSPNT = OSBOT
      ISEQN = OSCAR(OSPRC+1) + 1
C
C     LOAD HEADER
C
      OSCAR(OSPNT  ) = 6
      OSCAR(OSPNT+1) = ISEQN
      OSCAR(OSPNT+2) = 4 + LSHIFT(8,16)
      OSCAR(OSPNT+3) = XSAV(1)
      OSCAR(OSPNT+4) = XSAV(2)
      OSCAR(OSPNT+5) = DMPCNT
      CALL XLNKHD
C
C     HAVING THE VPS POINTERS FOR EACH PARAMETER, FIND THE
C     DISPLACEMENT IN COMMON
C
      J = OSPRC + 6 + 3*OSCAR(OSPRC+6) + 1
      IF (ANDF(OSCAR(OSPRC+2),MASKHI) .EQ. 1) J = J+1+3*OSCAR(J)
      J  = J + 1
      N3 = J+1
      N1 = OSCAR(J)
      N2 = 1
      OSCAR(OSPNT+6) = NWORDS
      OSCAR(OSPNT  ) = OSCAR(OSPNT) + 1
      IPT = 1
      IST = N3
140   IF (OSCAR(IST) .GT. 0) GO TO 110
C
C     SEEE IF PARAMETER IS IN SAVE LIST
C
C     LL = ANDF(OSCAR(IST),NOSGN )  REPLACED BY NEXT CARD, OCT. 1983
      LL = ANDF(OSCAR(IST),MASKHI)
      L  = ANDF(VPS(LL-1) ,MASKHI)
      DO 100 I = 1,NWORDS
      IF (ANDF(OSCAR(IST),NOSGN) .EQ. SAVNAM(I)) GO TO 120
100   CONTINUE
C
C     NOT TO BE SAVED, GO TO NEXT PARAMETER
C
      IST = IST + 1
      N2  = N2  + L
      GO TO 140
C
C     CONSTANT PARAMETER, SKIP IT
C
110   NWD = OSCAR(IST)
      IST = IST+NWD+1
      N2  = N2 + NWD
      GO TO 140
C
C     PARAMETER TO BE SAVED, PUT IN OSCAR
C
120   OSCAR(OSPNT+6+2*I-1) = SAVNAM(IPT)
      OSCAR(OSPNT+6+2*I  ) = N2
      OSCAR(OSPNT) = OSCAR(OSPNT) + 2
      IPT = IPT + 1
      IST = IST + 1
      N2  = N2  + L
      IF (IPT .LE. NWORDS) GO TO  140
      IHEAD = 0
      RETURN
      END
