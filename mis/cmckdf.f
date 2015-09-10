      SUBROUTINE CMCKDF
C
C     THIS SUBROUTINE DETERMINES WHETHER ALL (TRANSFORMED) LOCAL
C     COORDINATE SYSTEMS SPECIFIED AT A GIVEN CONNECTION ARE COMPATABLE
C
      LOGICAL         FIRST,FERROR
      INTEGER         SCCSTM,SCSFIL,SCCONN,SCORE,BUF2,ECPT1,IST(7),
     1                CE(9),CSTMID(7),COMBO,IDPSUB(7),NAM(2),OUTT
      DIMENSION       ECPT(4),CSTM(7,9),TT(9),IZ(1)
      CHARACTER       UFM*23
      COMMON /XMSSG / UFM
      COMMON /CMB001/ SCR1,SCR2,SCBDAT,SCSFIL,SCCONN,SCMCON,SCTOC,
     1                GEOM4,CASECC,SCCSTM,SCR3
      COMMON /CMB002/ BUF1,BUF2,BUF3,BUF4,BUF5,SCORE,LCORE,INTP,OUTT
      COMMON /CMB003/ COMBO(7,5),CONSET,IAUTO,TOLER,NPSUB,CONECT,TRAN,
     1                MCON,RESTCT(7,7),ISORT,ORIGIN(7,3),IPRINT
CZZ   COMMON /ZZCOMB/ Z(1)
      COMMON /ZZZZZZ/ Z(1)
      COMMON /BLANK / STEP,IDRY
      EQUIVALENCE     (IZ(1),Z(1)), (ECPT1,ECPT(1))
      DATA    NAM   / 4HCMCK,4HDF  /
C
      DO 10 I = 2,4
      ECPT(I) = 0.0
   10 CONTINUE
      FERROR  = .TRUE.
C
C     READ CSTM INTO OPEN CORE
C
      IFILE = SCCSTM
      ICSTM = SCORE
      LLCO  = LCORE
      CALL OPEN (*300,SCCSTM,Z(BUF2),0)
      CALL READ (*20,*20,SCCSTM,Z(ICSTM),LLCO,1,NW)
      GO TO 320
   20 LLCO = LLCO - NW
      CALL CLOSE (SCCSTM,1)
      IF (NW .EQ. 0) GO TO 350
      CALL PRETRS (Z(ICSTM),NW)
C
C     READ ALL BGSS FILES INTO OPEN CORE
C
      IBGSS = SCORE + NW
      IFILE = SCSFIL
      CALL OPEN (*300,SCSFIL,Z(BUF2),0)
      JJ = 0
      DO 50 I = 1,NPSUB
      IST(I) = IBGSS + JJ
      NCSUB  = COMBO(I,5) + 1
      DO 30 J = 1,NCSUB
      CALL FWDREC (*310,SCSFIL)
   30 CONTINUE
      CALL READ (*300,*40,SCSFIL,Z(IBGSS+JJ),LLCO,1,NN)
      GO TO 320
   40 LLCO = LLCO - NN
      JJ   = JJ + NN + 1
      CALL SKPFIL (SCSFIL,1)
   50 CONTINUE
      CALL CLOSE (SCSFIL,1)
C
C     BEGIN READING CONNECTION ENTRIES
C
      IFILE = SCCONN
      CALL OPEN (*300,SCCONN,Z(BUF2),0)
   60 CALL READ (*230,*70,SCCONN,CE,10,1,NN)
      GO TO 320
   70 NPT = 0
      DO 80 I = 1,NPSUB
C
C     CE(3)...CE(NN) ARE INTERNAL POINT NO.
C
      IF (CE(I+2) .EQ. 0) GO TO 80
      NPT = NPT + 1
      LOC = IST(I) + (CE(I+2)-1)*4
      CSTMID(NPT) = IZ(LOC)
      IDPSUB(NPT) = I
   80 CONTINUE
C
C     CHECK FOR NO CSTMS THIS ENTRY
C
      ISUM = 0
      DO 90 I = 1,NPT
      ISUM = ISUM + CSTMID(I)
   90 CONTINUE
      IF (ISUM .EQ. 0) GO TO 60
C
C     GET CSTM MATRICES AND LOAD INTO CSTM ARRAY
C
      DO 130 I = 1,NPT
      ECPT1 = CSTMID(I)
      IF (ECPT1 .EQ. 0) GO TO 110
      CALL TRANSS (ECPT,TT)
      DO 100 J = 1,9
      CSTM(I,J) = TT(J)
  100 CONTINUE
      GO TO 130
  110 DO 120 J = 1,9
      CSTM(I,J) = 0.0
  120 CONTINUE
      CSTM(I,1) = 1.0
      CSTM(I,5) = 1.0
      CSTM(I,9) = 1.0
  130 CONTINUE
C
C     COMPARE EACH MATRIX AGAINST OTHERS
C
      NPTM1 = NPT - 1
      DO 220 I = 1,NPTM1
      FIRST = .TRUE.
      J = I + 1
      DO 210 K  = J,NPT
      DO 140 KK = 1,9
      IF (ABS(CSTM(I,KK)-CSTM(K,KK)) .LT. 1.E-3) GO TO 140
      GO TO 150
  140 CONTINUE
      GO TO 210
  150 IF (.NOT.FERROR) GO TO 170
      FERROR = .FALSE.
      WRITE  (OUTT,160) UFM
  160 FORMAT (A23,' 6528, INCOMPATABLE LOCAL COORDINATE SYSTEMS HAVE ',
     1        'BEEN FOUND.', /5X,'CONNECTION OF POINTS IS IMPOSSIBLE',
C    2        ', SUMMARY FOLLOWS.', /5X,'(LOCAL COORDINATE SYSTEMS ARE',
C    3        ' THE TRNASFORMED OVERALL STSTEM GENERATED BY COMB1,',
C    4        /5X,'SEE PROGRM. MANUAL P 4.128-7, 9TH STEP)', //,
C    5        ' *** SUGGESTION - YOUR SUBSTRUCTURING PROBLEM MAY ',
C    6        'REQUIRE THE ''GTRAN'' CARD(S) ***',/)
C
     2        '. (SUGGESTION - USE ''GTRAN'' CARD(S))', /5X,
     3        'SUMMARY IN TERMS OF THE JUST-FORMED INTERNAL DOF AND ',
     4        'INTERNAL COORD. SYSTEM ID''S PER', /5X,
     5        'THE EQSS AND BGSS FOLLOWS.',/)
  170 IF (.NOT.FIRST) GO TO 190
      FIRST = .FALSE.
      ISUB  = IDPSUB(I) + 2
      WRITE  (OUTT,180) CSTMID(I),CSTM(I,1),CSTM(I,4),CSTM(I,7),
     1                  IDPSUB(I),CSTM(I,2),CSTM(I,5),CSTM(I,8),
     2                  CE(ISUB) ,CSTM(I,3),CSTM(I,6),CSTM(I,9)
  180 FORMAT (/1X,76(1H*),/,' THE FOLLOWING MISMATCHED LOCAL COORDINATE'
     1,      ' SYSTEMS (CSTM) HAVE BEEN FOUND FOR', //,
     2       ' LOCAL COORDINATE SYSTEM ID NO.',I9,8X,3E9.2, /,
     3       ' PSEUDOSTRUCTURE ID NO.',I5,20X,3E9.2, /,
     4       ' INTERNAL POINT NO.',I9,20X,3E9.2)
      IDRY  = -2
  190 ISUB  = IDPSUB(K) + 2
      WRITE  (OUTT,200) CSTMID(K),CSTM(K,1),CSTM(K,4),CSTM(K,7),
     1                  IDPSUB(K),CSTM(K,2),CSTM(K,5),CSTM(K,8),
     2                  CE(ISUB), CSTM(K,3),CSTM(K,6),CSTM(K,9)
  200 FORMAT (/12X,'AND',7X,'LOCAL COORDINATE SYSTEM ID NO.',I9,8X,
     1        3E9.2, /22X,'PSEUDOSTRUCTURE ID NO.',I5,20X,3E9.2,
     2        /22X,'INTERNAL POINT NO.',I9,20X,3E9.2)
  210 CONTINUE
  220 CONTINUE
      GO TO 60
C
  230 CALL CLOSE (SCCONN,1)
      GO TO 350
C
  300 IMSG = -1
      GO TO 330
  310 IMSG = -2
      GO TO 330
  320 IMSG = -8
  330 CALL MESAGE (IMSG,IFILE,NAM)
C
  350 RETURN
      END
