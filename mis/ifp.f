      SUBROUTINE IFP
C
      IMPLICIT INTEGER (A-Z)
      EXTERNAL        ORF,ANDF
      LOGICAL         BADFOR,BADDAT,ABORT,EOFFLG,CF,CL,IAX,LHARM
      INTEGER         FNM(2,16),II(16),IFLE(16),STATUS(16),IBLKDA(2),
     1                JR(20),IEND(3),ITRL(7),IFPNA1(2),NM(2),KAP(4),
     2                AP(12),KKL(40),IFPNA2(2),OOO(5),MENTRY(40),
     3                NAME(2),INAM(2),ITYPE(2),NENTRY(80),ITYPE1(2),
     4                ITYPE2(2)
      CHARACTER       UFM*23,UWM*25,UIM*29,SFM*25
      COMMON /XMSSG / UFM,UWM,UIM,SFM
      COMMON /BLANK / ENDARA(40)
      COMMON /SYSTEM/ N1,NOUT,ABORT,N2(17),IAPP,N3(5),AXICCC,JUNK(10),
     1                AXIFCC,DUM(30),ISUBS
      COMMON /TWO   / TWO(32)
      COMMON /IFPDTA/ ID,N,K,KX,KY,I(100),M(100),MF(100),M1(100),
     1                M1F(100),KN,BADDAT,BADFOR,NOPEN,NPARAM,IAX,NAX,
     2                IAXF,NAXF,LHARM,KNT,KSLOT1,KSLOT2,KSLOT3,KSLOT4,
     3                KSLOT5,GC(7),LL(6)
CZZ   COMMON /ZZIFPX/ IBUFF(1)
      COMMON /ZZZZZZ/ IBUFF(1)
C
C     NCDS    = LENGTH OF T1
C     NCDSMX  = NO. OF CARD NAMES IN NASTRAN
C     T3(1,K) = THE GINO OUTPUT FILE NUMBER
C     T3(2,K) = THE APPROACH ACCEPTANCE FLAG
C     T4(1,K) = THE CONICAL SHELL PROBLEM FLAG
C     T4(2,K) = USED AS INTERNAL STORAGE WITHIN IFP
C     T5(1,K) = THE MIN NO. OF WORDS ALLOWED PER CARD
C               (MINUS MEANS OPEN-ENDED CARD)
C     T5(2,K) = THE MAX NO. OF WORDS ALLOWED PER CARD
C     T6(1,K) = THE FORMAT CHECK POINTER INTO F( )
C     T6(2,K) = FIELD 2 UNIQUENESS CHECK FLAG
C     T7(1,K) = LOCATE CODE
C     T7(2,K) = TRAILER BIT POSITION
C     F(T6(1,K)) = THE START OF THE FORMAT ACCEPTANCE STRING
C
C     T1(1,K),T1(2,K) = THE BCD CARD NAMES
C
      COMMON /IFPX0 / LBD,LCC,IB(18)
      COMMON /IFPX1 / NCDS,T1(2,370)
      COMMON /IFPX2 / T3(2,370)
      COMMON /IFPX3 / T4(2,370)
      COMMON /IFPX4 / T5(2,370)
      COMMON /IFPX5 / T6(2,370)
      COMMON /IFPX6 / T7(2,370)
      COMMON /IFPX7 / F(1469)
      EQUIVALENCE     (N3(3),IUMFED), (N2(9),LINE)
      DATA    NCDSMX/ 359 /
      DATA    NFLS  / 16  /
      DATA    FNM(1, 1),FNM(2, 1) / 4HGEOM,4H1   /
      DATA    FNM(1, 2),FNM(2, 2) / 4HEPT ,4H    /
      DATA    FNM(1, 3),FNM(2, 3) / 4HMPT ,4H    /
      DATA    FNM(1, 4),FNM(2, 4) / 4HEDT ,4H    /
      DATA    FNM(1, 5),FNM(2, 5) / 4HDIT ,4H    /
      DATA    FNM(1, 6),FNM(2, 6) / 4HPVT ,4H    /
      DATA    FNM(1, 7),FNM(2, 7) / 4HDYNA,4HMICS/
      DATA    FNM(1, 8),FNM(2, 8) / 4HGEOM,4H2   /
      DATA    FNM(1, 9),FNM(2, 9) / 4HGEOM,4H3   /
      DATA    FNM(1,10),FNM(2,10) / 4HGEOM,4H4   /
      DATA    FNM(1,11),FNM(2,11) / 4HGEOM,4H5   /
      DATA    FNM(1,12),FNM(2,12) / 4HPOOL,4H    /
      DATA    FNM(1,13),FNM(2,13) / 4HFORC,4HE   /
      DATA    FNM(1,14),FNM(2,14) / 4HMATP,4HOOL /
      DATA    FNM(1,15),FNM(2,15) / 4HAXIC,4H    /
      DATA    FNM(1,16),FNM(2,16) / 4HIFPF,4HILE /
      DATA    IFLE   / 201,202,203,204,205,4HNPTP,207,208,209,210,211,
     1                 4HPOOL ,213,214,215,216   /
      DATA    IEND   , EOFZ   /3*65535,4HZZZZ    /
      DATA    KKL    / 48, 49, 50, 67, 71, 75, 68, 72, 76, 11,
     1                 10*0  ,
     2                 45, 46, 44, 41,250,260, 39, 42,121, 34,
     3                 37, 43, 31, 7*0/
      DATA    IBLKDA / 4HBULK, 4HDATA /,  OOO    / 1HA,1HB,1HC,1HD,1HE/
      DATA    BLANK  / 1H   /, KAP    / 0,-1,1,-1/
      DATA    IFPNA1 / 4HIFP ,4HBEGN/, IFPNA2/ 4HIFP ,4HEND /
      DATA    IPARM  , IVARY /4H1PAR , 4H1VAR/
      DATA    ICOUNT , JCOUNT, KCOUNT/ 3*0   /
CIBMD DATA    IT1K   , IT2K  , JT1K  ,JT2K   , KT1K  , KT2K / 6*1H    /
CIBMNB 6/93
      DATA    IT1K   , IT2K  , JT1K  ,JT2K   , KT1K  ,KT2K /
     &        1H , 1H , 1H , 1H , 1H , 1H   /
CIBMNE
      DATA    AP     / 4HDMAP,4H     , 4H    ,
     1                 4HDISP,4HLACE , 4HMENT,
     2                 4HHEAT,4H     , 4H    ,
     3                 4HAERO,4H     , 4H    /
      DATA    MENTRY / 3001  , 3701  ,  3901 ,  1201 ,   401,
     1                  801  , 1301  ,   501 ,   901 ,  5201, 10*0,
     2                  202  ,  302  ,   402 ,   502 ,  2202,
     3                 5302  ,  802  ,  1002 ,  2102 ,  1302,
     4                 1402  , 1702  ,  1802 ,   7*0 /
      DATA    NAME   / 4HIFP , 4H    /
      DATA    NENTRY / 4HCROD, 4H    , 4HCTUB, 4HE   , 4HCVIS, 4HC   ,
     1                 4HCMAS, 4HS3  , 4HCDAM, 4HP3  , 4HCELA, 4HS3  ,
     2                 4HCMAS, 4HS4  , 4HCDAM, 4HP4  , 4HCELA, 4HS4  ,
     3                 4HPLOT, 4HEL  , 20*0  ,
     4                 4HPDAM, 4HP   , 4HPELA, 4HS   , 4HPMAS, 4HS   ,
     5                 4HPQDM, 4HEM  , 4HPQDM, 4HEM1 , 4HPQDM, 4HEM2 ,
     6                 4HPQUA, 4HD2  , 4HPSHE, 4HAR  , 4HPTOR, 4HDRG ,
     7                 4HPTRI, 4HA2  , 4HPTRM, 4HEM  , 4HPTWI, 4HST  ,
     8                 4HPVIS, 4HC   , 14*0  /
      DATA    ITYPE1 / 4HELEM, 4HENT /
      DATA    ITYPE2 / 4HPROP, 4HERTY/
C
C     ============================================================
C     REMEMBER TO CHECK FOR THE LONGEST LINK IN OVERLAY STRUCTURE.
C     ============================================================
C
C     INITIALIZE COMMON BLOCKS CIFS1P, 2P, 3P, 4P, AND CIFS5P
C
      CALL CIFSDD
C
      DO 10 J = 1,16
      STATUS(J) = 1
   10 CONTINUE
      STATUS( 6) = 3
      STATUS(12) = 3
      LM     = 100
      CURFIL = 0
      KICK   = 0
      IPVS   = 0
      EOFFLG = .FALSE.
      BADDAT = .FALSE.
      BADFOR = .FALSE.
      NPARAM = 0
      KN     = 0
      IAX    = .FALSE.
      NAX    =-1
      IAXF   = 0
      NAXF   =-1
      LHARM  = .TRUE.
      KSLOT1 = 0
      KSLOT2 = 0
      KSLOT3 = 0
      KSLOT4 = 0
      KSLOT5 = 0
      CALL CONMSG (IFPNA1,2,0)
      IAP    = IABS(IAPP)
      JAP    = KAP(IAP)
      KNT    =-1
      IAXIC  = AXICCC
      IAXIF  = AXIFCC
      AXICCC = 0
      AXIFCC = 0
      DO 20 J = 1,NFLS
   20 II(J)  = 0
      DO 30 J = 1,40
      ENDARA(J) = 0
   30 CONTINUE
      NOPEN = KORSZ(IBUFF) - 3*N1
      CALL SSWTCH (42,L42)
      IF (NOPEN .GE. 0) GO TO 100
      CALL PAGE2 (2)
      WRITE  (NOUT,40) SFM
   40 FORMAT (A25,' 303, NO OPEN CORE FOR IFP.')
      ABORT =.TRUE.
      RETURN
C
C     OPEN NPTP AND LOCATE BULK DATA
C
  100 KFIL = IFLE(6)
      CALL OPEN (*130,KFIL,IBUFF(N1+1),0)
  110 CALL SKPFIL (KFIL,1)
      CALL READ (*1390,*160,KFIL,JR,2,1,KDUM)
      IF (JR(1).EQ.IBLKDA(1) .AND. JR(2).EQ.IBLKDA(2)) GO TO 180
      KICK = KICK + 1
      IF (KICK .LT. 5) GO TO 110
      CALL PAGE2 (2)
      WRITE  (NOUT,120) SFM,JR(1),JR(2)
  120 FORMAT (A25,' 304, IFP NOT READING NPTP. FILE BEING READ = ',2A4)
      GO TO 150
  130 CALL PAGE2 (2)
      WRITE  (NOUT,140) SFM,KFIL
  140 FORMAT (A25,' 305, IFP CANNOT OPEN GINO FILE',I10)
  150 ABORT =.TRUE.
      GO TO 1850
  160 CALL PAGE2 (2)
      WRITE  (NOUT,170) SFM
  170 FORMAT (A25,' 306, READ LOGICAL RECORD ERROR')
      GO TO 150
  180 CALL READ (*1380,*160,IFLE(6),JR,20,1,KDUM)
      KNT = KNT + 1
C
C     CHECK FOR 1PARM OR 1VARY CARDS
C
      IF (JR(1).EQ.IPARM .OR. JR(1).EQ.IVARY) CALL IFPPVC (*190,IPVS,JR)
      IF (L42 .EQ. 0) CALL RCARD2 (M1,M1F,NW,JR)
      IF (L42 .NE. 0) CALL RCARD  (M1,M1F,NW,JR)
      IF (M1(1).EQ.0 .AND. M1(2).EQ.0) GO TO 1430
      GO TO 220
  190 CALL CLOSE (IFLE(6),1)
      GO TO 1900
C
C     READ AND DECODE ONE PHYSICAL CARD
C
  200 IF (EOFFLG) GO TO 1410
      CALL READ (*1460,*160,IFLE(6),JR,20,1,KDUM)
      KNT = KNT + 1
      IF (L42 .EQ. 0) CALL RCARD2 (M1,M1F,NW,JR)
      IF (L42 .NE. 0) CALL RCARD  (M1,M1F,NW,JR)
      IF (M1(1).EQ.0 .AND. M1(2).EQ.0) GO TO 200
  210 IF (EOFFLG) GO TO 1460
C
C     IDENTIFY CARD NAME
C
  220 DO 230 J = 1,NCDSMX
      K = J
      IF (M1(1).EQ.T1(1,K) .AND. M1(2).EQ.T1(2,K)) GO TO 280
  230 CONTINUE
      IF (KT1K.NE.T1(1,K) .OR. KT2K.NE.T1(2,K)) GO TO 240
      KCOUNT = KCOUNT + 1
      IF (KCOUNT-7) 250,270,200
  240 KT1K = T1(1,K)
      KT2K = T1(2,K)
  250 CALL PAGE2 (2)
      WRITE  (NOUT,260) UFM,M1(1),M1(2)
  260 FORMAT (A23,' 307, ILLEGAL NAME FOR BULK DATA CARD ',2A4 )
      ABORT =.TRUE.
      GO TO 200
  270 CALL PAGE2 (3)
      WRITE  (NOUT,1150)
      GO TO 200
  280 KCOUNT = 0
      CL =.FALSE.
      CF =.TRUE.
      KX = K  - 100
      KY = KX - 100
C
C     CHECK APPROACH ACCEPTABILITY
C
      IF (T3(2,K)*JAP+1) 300,320,340
  300 WRITE  (NOUT,310) UFM,T1(1,K),T1(2,K),AP(3*IAP-2),AP(3*IAP-1),
     1                  AP(3*IAP)
  310 FORMAT (A23,' 308, CARD ',2A4,' NOT ALLOWED IN ',3A4,' APPROACH.')
      CALL PAGE2 (2)
      ABORT =.TRUE.
      GO TO 340
  320 WRITE  (NOUT,330) UWM,T1(1,K),T1(2,K),AP(3*IAP-2),AP(3*IAP-1),
     1                  AP(3*IAP)
  330 FORMAT (A25,' 309, CARD ',2A4,' IMPROPER IN ',3A4,' APPROACH.')
      CALL PAGE2(2)
  340 IF (.NOT.IAX .OR. T4(1,K).GE.0) GO TO 400
      CALL PAGE2 (2)
      WRITE  (NOUT,350) UFM,T1(1,K),T1(2,K)
  350 FORMAT (A23,' 310, CARD ',2A4,' NOT ALLOWED IN SAME DECK WITH ',
     1       'AXIC CARD.')
      ABORT =.TRUE.
C
C     ESTABLISH PROPER OUTPUT FILES FOR THIS CARD
C
  400 INDX = T3(1,K)
      IF (INDX.EQ.CURFIL .OR. INDX.EQ.6) GO TO 420
      IF (CURFIL.EQ.0 .OR. STATUS(CURFIL).EQ.1) GO TO 410
      CALL CLOSE (IFLE(CURFIL),2)
      STATUS(CURFIL) = 3
  410 KFIL = IFLE(INDX)
      CALL OPEN (*130,KFIL,IBUFF,STATUS(INDX))
      CURFIL = INDX
      STATUS(CURFIL) = -STATUS(CURFIL)
      IF (STATUS(CURFIL) .NE. -1) GO TO 420
      CALL WRITE (IFLE(CURFIL),FNM(1,CURFIL),2,1)
      II(CURFIL) = 1
      STATUS(CURFIL) = -3
  420 ID = M1(3)
  430 JF = NW - 2
      DO 440 L = JF,LM
  440 M(L) = 0
      DO 450 L = 1,JF
  450 M(L) = M1(L+2)
C
C     TEST UNIQUENESS OF FIELD 2 IF APPLICABLE
C
      IF (M1(1).EQ.0 .AND. M1(2).EQ.0 .OR.CF .OR. T6(2,K).NE.1)
     1    GO TO 480
      IF (ID .EQ. M(1)) GO TO 460
      ID = M(1)
      GO TO 480
  460 KNT1 = KNT + 1
      CALL PAGE2 (2)
      WRITE  (NOUT,470) UFM,T1(1,K),T1(2,K),M(1),KNT1
  470 FORMAT (A23,' 311, NON-UNIQUE FIELD 2 ON BULK DATA CARD ',2A4,I8,
     1        10X,'H SORTED CARD COUNT =',I7)
      ABORT =.TRUE.
  480 DO 490 L = 1,LM
  490 MF(L) = 0
      LF = 0
      DO 500 L = 1,JF
C
C     =========================================
C     THIS SHOULD BE CHANGED WHEN RCARD CHANGES
C
      IF (M1F(L+1) .LT. 0) GO TO 540
C     ========================================
      LF = LF + 1
  500 MF(L) = M1F(L+1)
      GO TO 540
  510 IF (EOFFLG) GO TO 1420
C
C     READ ANOTHER CARD (TO BE PROCESSED NEXT)
C
      KNT = KNT + 1
      CALL READ (*550,*160,IFLE(6),JR,20,1,KDUM)
      IF (L42 .EQ. 0) CALL RCARD2 (M1,M1F,NW,JR)
      IF (L42 .NE. 0) CALL RCARD  (M1,M1F,NW,JR)
      IF (M1(1).NE.0  .OR. M1(2).NE.0) GO TO 580
C
C     CHECK FOR TOO MANY CONTINUATIONS
C
      IF (T6(1,K).LT.0 .AND. LF.GT.4) GO TO 600
      IF (JF+NW-2-LM .GT. 0) GO TO 560
      K1 = NW - 2
      DO 520 L = 1,K1
      K2 = JF + L
  520 M(K2) = M1(L+2)
      JF = JF + NW - 2
      DO 530 L = 1,K1
C
C     =========================================
C     THIS SHOULD BE CHANGED WHEN RCARD CHANGES
C
      IF (M1F(L+1) .LT. 0) GO TO 540
C     =========================================
      LF = LF + 1
  530 MF(LF) = M1F(L+1)
  540 MF(LF+1) = -32767
      GO TO 510
  550 EOFFLG =.TRUE.
      M1(1)  = EOFZ
      M1(2)  = EOFZ
      GO TO 590
  560 WRITE  (NOUT,570) UFM,T1(1,K),T1(2,K),M(1),KNT
  570 FORMAT (A23,' 312, TOO MANY CONTINUATIONS FOR BULK DATA CARD ',
     1        2A4,I8,6X,'SORTED CARD COUNT =',I7)
      CALL PAGE2 (2)
      ABORT =.TRUE.
      GO TO 510
  580 IF (M1(1).EQ.T1(1,K) .AND. M1(2).EQ.T1(2,K)) GO TO 600
  590 CL =.TRUE.
  600 IF (.NOT.CF .OR. T6(2,K).EQ.2) GO TO 610
      KKK = T3(1,K)
      II(KKK) = II(KKK) + 1
      CF =.FALSE.
      IF (KKK.EQ.6 .OR. KKK.EQ.12) GO TO 640
      ITRL(1) = T7(1,K)
      ITRL(2) = T7(2,K)
      ITRL(3) = K
      CALL WRITE (IFLE(CURFIL),ITRL,3,0)
C
C     CHECK FOR MIN-MAX NO. OF WORDS
C
  610 IF (T5(1,K) .LT. 0) GO TO 640
      L = JF
      IF (T5(1,K)-L) 630,690,650
  620 L = L + 4
  630 IF (T5(2,K)-L) 650,690,620
  640 L =-T5(1,K)
      IF (JF.GE.L .AND. JF.LE.T5(2,K)) GO TO 690
  650 WRITE  (NOUT,660) UFM,T1(1,K),T1(2,K),M(1),KNT
  660 FORMAT (A23,' 313, ILLEGAL NUMBER OF WORDS ON BULK DATA CARD ',
     1        2A4,I8,6X,'SORTED CARD COUNT =',I7)
      WRITE  (NOUT,670) T5(1,K),T5(2,K),K,L,JF
  670 FORMAT ('   T5(1&2,K),K,L,JF =',5I4)
      CALL PAGE2 (2)
      ABORT =.TRUE.
      IF (T6(1,K)) 710,680,680
  680 IF (.NOT.CL) GO TO 430
      IF (T6(2,K) .EQ. 2) GO TO 210
      CALL WRITE (IFLE(CURFIL),M,0,1)
      IF (T4(2,K) .GT. 0) GO TO 210
      II(KKK) = II(KKK) - 1
      CALL BCKREC (IFLE(CURFIL))
      GO TO 210
C
C     CHECK FOR PROPER FORMAT
C
  690 IF (T6(1,K) .LT. 0) GO TO 710
      L  = T6(1,K)
      L1 = 0
      DO 700 K1 = 1,LF
      L1 = L1 + 1
      IF (MF(K1) .EQ. 3) L1 = L1 + 1
      K2 = L + K1 - 1
      IF (F(K2).EQ.MF(K1) .OR. F(K2).EQ.5) GO TO 700
      IF (MF(K1).EQ.1    .AND. M(L1).EQ.0) GO TO 700
      IF (MF(K1).NE.0 .OR. F(K2).NE.1 .AND. F(K2).NE.2) GO TO 1350
  700 CONTINUE
  710 N = 0
      BADDAT =.FALSE.
      BADFOR =.FALSE.
      IF (IPVS .NE. 0) CALL IFPMDC
C
C     CALL SECONDARY ROUTINE TO EXAMINE EACH TYPE OF CARD
C
      KB = (K-1)/20 + 1
      IF (KB .GT. 18) GO TO 1060
      GO TO ( 810, 820, 830, 840, 850, 860, 870, 880, 890, 900,
     1        910, 920, 930, 940, 950, 960, 970, 980), KB
  810 KB = K
      GO TO (1030,1030,1050,1010,1010,1010,1010,1010,1010,1010,
     1       1010,1030,1030,1010,1010,1010,1030,1010,1010,1010), KB
  820 KB = K - 20
      GO TO (1010,1010,1010,1010,1010,1010,1010,1030,1010,1010,
     1       1010,1050,1010,1010,1010,1010,1010,1010,1010,1010), KB
  830 KB = K - 40
      GO TO (1010,1010,1010,1010,1010,1010,1010,1010,1010,1010,
     1       1050,1010,1010,1010,1010,1010,1010,1010,1010,1010), KB
  840 KB = K - 60
      GO TO (1010,1010,1010,1010,1010,1010,1010,1010,1010,1010,
     1       1010,1010,1010,1010,1010,1010,1010,1010,1040,1040), KB
  850 KB = K - 80
      GO TO (1010,1030,1030,1030,1020,1020,1020,1050,1020,1040,
     1       1040,1030,1020,1020,1020,1020,1020,1040,1050,1050), KB
  860 KB = K - 100
      GO TO (1050,1040,1050,1040,1040,1050,1050,1050,1050,1050,
     1       1050,1050,1050,1050,1050,1050,1050,1050,1020,1020), KB
  870 KB = K - 120
      GO TO (1010,1040,1030,1040,1010,1030,1010,1010,1010,1010,
     1       1030,1030,1020,1020,1010,1010,1010,1030,1030,1020), KB
  880 KB = K - 140
      GO TO (1020,1010,1030,1030,1030,1030,1030,1030,1030,1030,
     1       1030,1030,1030,1030,1030,1030,1030,1010,1050,1050), KB
  890 KB = K - 160
      GO TO (1050,1020,1050,1050,1050,1010,1050,1050,1050,1050,
     1       1050,1050,1050,1050,1050,1050,1050,1050,1010,1010), KB
  900 KB = K - 180
      GO TO (1010,1030,1030,1030,1030,1050,1050,1020,1040,1010,
     1       1020,1020,1050,1050,1040,1040,1060,1050,1040,1020), KB
  910 KB = K - 200
      GO TO (1040,1040,1040,1040,1040,1040,1040,1040,1040,1040,
     1       1040,1040,1040,1040,1010,1030,1040,1040,1040,1040), KB
  920 KB = K - 220
      GO TO (1040,1040,1010,1010,1010,1010,1010,1010,1010,1010,
     1       1010,1010,1010,1010,1010,1010,1010,1010,1040,1010), KB
  930 KB = K - 240
      GO TO (1010,1040,1010,1030,1050,1050,1050,1050,1010,1010,
     1       1050,1050,1050,1050,1050,1010,1010,1010,1010,1010), KB
  940 KB = K - 260
      GO TO (1020,1020,1050,1050,1050,1050,1050,1010,1050,1050,
     1       1050,1050,1030,1030,1050,1050,1050,1050,1030,1020), KB
  950 KB = K - 280
      GO TO (1020,1020,1020,1030,1030,1030,1030,1030,1010,1030,
     1       1010,1010,1010,1010,1040,1040,1030,1030,1010,1010), KB
  960 KB = K - 300
      GO TO (1050,1050,1050,1050,1050,1050,1050,1050,1050,1050,
     1       1050,1050,1050,1050,1010,1010,1010,1010,1010,1010), KB
  970 KB = K - 320
      GO TO (1040,1040,1040,1040,1040,1040,1040,1040,1030,1030,
     1       1010,1030,1040,1040,1040,1040,1010,1050,1050,1010), KB
  980 KB = K - 340
      GO TO (1010,1010,1010,1010,1030,1030,1030,1030,1030,1030,
     1       1030,1030,1030,1020,1060,1010,1010,1010,1010,1060), KB
 1010 CALL IFS1P (*1360,*680,*1100)
      GO TO 1230
 1020 CALL IFS2P (*1360,*680,*1100)
      GO TO 1230
 1030 CALL IFS3P (*1360,*680,*1100)
      GO TO 1230
 1040 CALL IFS4P (*1360,*680,*1100)
      GO TO 1230
 1050 CALL IFS5P (*1360,*680,*1100)
      GO TO 1230
 1060 CALL PAGE2 (2)
      WRITE  (NOUT,1070) SFM,K
 1070 FORMAT (A25,' 314, INVALID CALL FROM IFP.  K =',I10)
      ABORT =.TRUE.
      GO TO 1850
C
 1100 IF (.NOT.BADFOR) GO TO 1160
      IF (IT1K.NE.T1(1,K) .OR. IT2K.NE.T1(2,K)) GO TO 1110
      ICOUNT = ICOUNT + 1
      IF (ICOUNT-7) 1120,1140,1170
 1110 IT1K = T1(1,K)
      IT2K = T1(2,K)
 1120 CALL PAGE2 (2)
      IF (ID .EQ. 0) ID = M(1)
      WRITE  (NOUT,1130) UFM,T1(1,K),T1(2,K),ID,KNT
 1130 FORMAT (A23,' 315, FORMAT ERROR ON BULK DATA CARD ',2A4,I8,17X,
     1       'SORTED CARD COUNT =',I7)
      GO TO 1170
 1140 CALL PAGE2 (3)
      WRITE  (NOUT,1150)
 1150 FORMAT (31X,'.', /29X,'MORE', /31X,'.')
      GO TO 1170
 1160 IF (.NOT.BADDAT) ICOUNT = 0
 1170 IF (.NOT.BADDAT) GO TO 1220
      IF (JT1K.NE.T1(1,K) .OR. JT2K.NE.T1(2,K)) GO TO 1180
      JCOUNT = JCOUNT + 1
      IF (JCOUNT-7) 1190,1210,1230
 1180 JT1K = T1(1,K)
      JT2K = T1(2,K)
 1190 CALL PAGE2 (2)
      IF (ID .EQ. 0) ID = M(1)
      WRITE  (NOUT,1200) UFM,T1(1,K),T1(2,K),ID,KNT
 1200 FORMAT (A23,' 316, ILLEGAL DATA ON BULK DATA CARD ',2A4,I8,17X,
     1       'SORTED CARD COUNT =',I7)
      GO TO 1230
 1210 CALL PAGE2 (3)
      WRITE (NOUT,1150)
      GO TO 1230
 1220 IF (.NOT.BADFOR) JCOUNT = 0
 1230 IF (.NOT.BADFOR .AND. .NOT.BADDAT) GO TO 1300
      N = 0
      ABORT =.TRUE.
      GO TO 1340
C
C     WRITE OUT CARD DATA ON APPROPRIATE IFP OUTPUT FILE
C
 1300 IF (N .EQ. 0) GO TO 1340
      T4(2,K) = T4(2,K) + N
      DO 1310 L = 1,40
      IF (K .EQ. KKL(L)) GO TO 1320
 1310 CONTINUE
      GO TO 1330
 1320 CALL WRITE (IFLE(CURFIL),I,N,0)
      GO TO 1340
 1330 CONTINUE
      IF (INDX.NE.6 .AND. .NOT.ABORT .OR. INDX.EQ.15)
     1   CALL WRITE (IFLE(CURFIL),I,N,0)
 1340 IF (KN .EQ. 0) GO TO 680
      KN = 0
      GO TO 430
 1350 BADFOR =.TRUE.
 1360 IF (.NOT.BADFOR) GO TO 1370
      CALL PAGE2 (2)
      WRITE (NOUT,1130) UFM,T1(1,K),T1(2,K),M(1),KNT
      ABORT = .TRUE.
 1370 IF (.NOT.BADDAT) GO TO 1380
      CALL PAGE2 (2)
      WRITE (NOUT,1200) UFM,T1(1,K),T1(2,K),M(1),KNT
      ABORT =.TRUE.
      GO TO 680
 1380 IF (IAPP  .EQ. 1) GO TO 1850
      IF (ISUBS .NE. 0) GO TO 1850
 1390 WRITE  (NOUT,1400) SFM
 1400 FORMAT (A25,' 319, IFP READING EOF ON NPTP.')
      CALL PAGE2 (2)
      ABORT =.TRUE.
      GO TO 1850
 1410 KERROR = 1410
      GO TO 1440
 1420 KERROR = 1420
      GO TO 1440
 1430 KERROR = 1430
 1440 CALL PAGE2 (6)
      WRITE  (NOUT,1450) SFM,KERROR,(JR(L),L=1,20),KNT
 1450 FORMAT (A25,' 320, IFP ERROR',I5, /5X,'LAST CARD PROCESSED IS -',
     1        20A4,1H-, /5X,'SORTED CARD COUNT =',I7)
      ABORT =.TRUE.
      GO TO 1850
 1460 IF (CURFIL .NE. 0) CALL CLOSE (IFLE(CURFIL),2)
      DO 1470 L = 1,NFLS
      IF (L.EQ.6 .OR. L.EQ.12 .OR. STATUS(L).EQ.1) GO TO 1470
      KFIL = IFLE(L)
      CALL OPEN  (*130,KFIL,IBUFF,3)
      CALL WRITE (IFLE(L),IEND,3,1)
      II(L) = II(L) + 1
      CALL CLOSE (IFLE(L),1)
 1470 CONTINUE
C
C     CHECK TO SEE IF ALL MULTI-ENTRY CARD DATA (CROD, CTUBE, ETC.)
C     ARE SORTED ON THEIR ELEMENT/PROPERTY IDS
C
      DO 1480 L = 1,40
      IF (ENDARA(L) .LT. 0) GO TO 1490
 1480 CONTINUE
C
C     EITHER NO MULTI-ENTRY CARD DATA EXIST OR, IF THEY DO,
C     THEY ARE ALL SORTED ON THEIR ELEMENT/PROPERTY IDS
C
      GO TO 1700
C
C     NOT ALL MULTI-ENTRY CARD DATA ARE SORTED ON THEIR
C     ELEMENT/PROPERTY IDS.
C
C     CLOSE SCRATCH FILE (FILE 6) AT CURRENT POSITION WITHOUT REWIND
C     AND WITHOUT END-OF-FILE.
C
 1490 CALL CLOSE (IFLE(6),2)
C
C     READ DATA FROM GEOM2/EPT FILE, SORT ALL MULTI-ENTRY CARD DATA ON
C     THEIR ELEMENT/PROPERTY IDS AND WRITE THE RESULTING DATA ON
C     SCRATCH FILE (FILE 16)
C
C     NOTE.  GEOM2 IS IFLE(8) AND EPT IS IFLE(2)
C
      DO 1690 NNN = 1,2
      IF (NNN .EQ. 2) GO TO 1500
      IFILE   = IFLE(8)
      INAM(1) = FNM(1,8)
      INAM(2) = FNM(2,8)
      ITYPE(1)= ITYPE1(1)
      ITYPE(2)= ITYPE1(2)
      JMIN    = 1
      JMAX    = 20
      GO TO 1510
 1500 IFILE   = IFLE(2)
      INAM(1) = FNM(1,2)
      INAM(2) = FNM(2,2)
      ITYPE(1)= ITYPE2(1)
      ITYPE(2)= ITYPE2(2)
      JMIN    = 21
      JMAX    = 40
 1510 DO 1520 L = JMIN,JMAX
      IF (ENDARA(L) .LT. 0) GO TO 1530
 1520 CONTINUE
      GO TO 1690
 1530 ILEFT = NOPEN - NPARAM - 2
      ISTRT = 2*N1  + NPARAM + 2
      CALL GOPEN (IFILE,IBUFF,0)
      KFIL = IFLE(16)
      CALL OPEN  (*130,IFLE(16),IBUFF(N1+1),1)
      CALL WRITE (IFLE(16),INAM,2,1)
      INDEX = JMIN
 1540 CALL READ (*1680,*1670,IFILE,IBUFF(ISTRT),3,0,IFLAG)
      CALL WRITE (IFLE(16),IBUFF(ISTRT),3,0)
      IF (INDEX .GT. JMAX) GO TO 1560
      DO 1550 L = JMIN,JMAX
      IF (IBUFF(ISTRT).EQ.MENTRY(L) .AND. ENDARA(L).LT.0) GO TO 1580
 1550 CONTINUE
 1560 CALL READ  (*1660,*1570,IFILE,IBUFF(ISTRT),ILEFT,0,IFLAG)
      CALL WRITE (IFLE(16),IBUFF(ISTRT),ILEFT,0)
      GO TO 1560
 1570 CALL WRITE (IFLE(16),IBUFF(ISTRT),IFLAG,1)
      GO TO 1540
 1580 INDEX = INDEX + 1
      CALL PAGE2 (3)
      WRITE  (NOUT,1590) UIM,NENTRY(2*L-1),NENTRY(2*L),ITYPE
 1590 FORMAT (A29,' 334, ',2A4,' MULTI-ENTRY CARD DATA ARE NOT SORTED ',
     1       'ON THEIR ',2A4,' IDS.', /5X,
     2       'SUBROUTINE IFP WILL SORT THE DATA.')
      IFAIL = 0
 1600 CALL READ (*1660,*1610,IFILE,IBUFF(ISTRT),ILEFT,0,IFLAG)
      IFAIL = IFAIL + 1
      GO TO 1600
 1610 IF (IFAIL .EQ. 0) GO TO 1630
      NWDS = (IFAIL-1)*ILEFT + IFLAG
      CALL PAGE2 (4)
      WRITE  (NOUT,1620) UFM,NENTRY(2*L-1),NENTRY(2*L),NWDS
 1620 FORMAT (A23,' 333, UNABLE TO SORT ',2A4,' MULTI-ENTRY CARD DATA ',
     1       'IN SUBROUTINE IFP DUE TO INSUFFICIENT CORE.', /5X,
     3       'ADDITIONAL CORE REQUIRED =',I10,7H  WORDS)
      CALL MESAGE (-61,0,0)
 1630 NWDS = 4
      IF (L.EQ.10 .OR. L.EQ.33) NWDS = 3
      IF (L.EQ.21 .OR. L.EQ.23) NWDS = 2
      CALL SORT  (0,0,NWDS,1,IBUFF(ISTRT),IFLAG)
      CALL WRITE (IFLE(16),IBUFF(ISTRT),IFLAG,1)
C
C     CHECK SORTED MULTI-ENTRY CARD DATA FOR NON-UNIQUE
C     ELEMENT/PROPERTY IDS
C
      IREPT = -10000000
      NIDSM1= IFLAG/NWDS - 1
      DO 1650 KK = 1,NIDSM1
      EID   = IBUFF(ISTRT+KK*NWDS)
      EIDM1 = IBUFF(ISTRT+KK*NWDS-NWDS)
      IF (EID .NE. EIDM1) GO TO 1650
      IF (EID .EQ. IREPT) GO TO 1650
      IREPT = EID
      ABORT = .TRUE.
      CALL PAGE2 (2)
      WRITE  (NOUT,1640) UFM,ITYPE,EID,NENTRY(2*L-1),NENTRY(2*L)
 1640 FORMAT (A23,' 335, NON-UNIQUE ',2A4,' ID',I9,' ENCOUNTERED IN ',
     1        2A4,' MULTI-ENTRY CARD DATA.')
 1650 CONTINUE
      GO TO 1540
 1660 CALL MESAGE (-2,IFILE,NAME)
 1670 CALL MESAGE (-3,IFILE,NAME)
 1680 CALL CLOSE  (IFILE,1)
      CALL CLOSE  (IFLE(16),1)
C
C     COPY DATA BACK FROM SCRATCH FILE (FILE 16) TO GEOM2/EPT FILE
C
      KFIL = IFLE(16)
      CALL OPEN (*130,IFLE(16),IBUFF,0)
      KFIL = IFILE
      CALL OPEN (*130,IFILE,IBUFF(N1+1),1)
      CALL CPYFIL (IFLE(16),IFILE,IBUFF(ISTRT),ILEFT,IFLAG)
      CALL CLOSE (IFLE(16),1)
      CALL CLOSE (IFILE,1)
 1690 CONTINUE
C
C     RE-OPEN SCRATCH FILE (FILE 6) TO WRITE WITHOUT REWIND
C
      KFIL = IFLE(6)
      CALL OPEN (*130,IFLE(6),IBUFF(N1+1),3)
C
C     WRITE TRAILERS
C
 1700 DO 1740 J = 1,NFLS
      IF (J.EQ.6 .OR. J.EQ.12) GO TO 1740
      DO 1710 L = 2,7
 1710 ITRL(L) = 0
      ITRL(1) = IFLE(J)
      IF (II(J).LE.2 .OR. ABORT) GO TO 1730
      DO 1720 L = 1,NCDSMX
      IF (T3(1,L).NE.J .OR. T4(2,L).LE.0) GO TO 1720
      KT721 = ANDF(T7(2,L),511)
      K1 = (KT721-1)/16 + 2
      K2 = KT721 - (K1-2)*16 + 16
      ITRL(K1) = ORF(ITRL(K1),TWO(K2))
 1720 CONTINUE
 1730 CALL WRTTRL (ITRL)
 1740 CONTINUE
C
C     WRITE PARAM CARDS ON NPTP
C
      KFIL = IFLE(16)
      CALL IFPPAR
      IF (NPARAM.LE.0 .OR. ABORT) GO TO 1850
      CALL OPEN (*130,KFIL,IBUFF,1)
      ITRL(1) = KFIL
      ITRL(2) = NPARAM
      CALL WRTTRL (ITRL(1))
      CALL WRITE (KFIL,FNM(1,6),2,1)
      CALL WRITE (KFIL,IBUFF(2*N1+1),NPARAM,1)
      IPM   = 1
      IPN   = 2*N1 + IPM
      GO TO 1840
 1800 IPN   = 2*N1 + IPM
      NM(1) = IBUFF(IPN  )
      NM(2) = IBUFF(IPN+1)
      JPM   = 1
 1810 JPN   = 2*N1 + JPM
      IF (NM(1).NE.IBUFF(JPN) .OR. NM(2).NE.IBUFF(JPN+1)) GO TO 1830
      CALL PAGE2 (2)
      WRITE  (NOUT,1820) UFM,NM(1),NM(2)
 1820 FORMAT (A23,' 321, NON-UNIQUE PARAM NAME - ',2A4,1H-)
      ABORT =.TRUE.
 1830 JPM   = JPM + 4
      IF (IBUFF(JPN+2) .GT. 2) JPM = JPM + 1
      IF (IBUFF(JPN+2) .GT. 5) JPM = JPM + 2
      IF (JPM .LT. IPM) GO TO 1810
 1840 IPM = IPM + 4
      IF (IBUFF(IPN+2) .GT. 2) IPM = IPM + 1
      IF (IBUFF(IPN+2) .GT. 5) IPM = IPM + 2
      IF (IPM .LT. NPARAM) GO TO 1800
      CALL EOF (KFIL)
      CALL CLOSE (KFIL,1)
 1850 CALL CLOSE (IFLE(6),1)
C
C     CHECK FOR PROPERTY ID UNIQUENESS IN EPT FILE AND PROPERTY ID
C     SPECIFIED IN GEOM2 ELEMENTS
C
      CALL SSWTCH (34,JJ1)
      IF (JJ1 .EQ. 1) GO TO 1900
      KFIL = IFLE(2)
      ITRL(1) = KFIL
      CALL RDTRL (ITRL)
      J = ITRL(2) + ITRL(3) + ITRL(4) + ITRL(5) + ITRL(6) + ITRL(7)
      JJ1 = 1
      IF (ITRL(1).LT.0 .OR. J.EQ.0) GO TO 1860
      JJ1 = 0
      CALL OPEN (*130,KFIL,IBUFF,0)
 1860 KFIL = IFLE(8)
      ITRL(1) = KFIL
      CALL RDTRL (ITRL)
      J = ITRL(2) + ITRL(3) + ITRL(4) + ITRL(5) + ITRL(6) + ITRL(7)
      IF (ITRL(1).LT.0 .OR. J.EQ.0) GO TO 1880
      CALL OPEN (*130,KFIL,IBUFF(N1+1),0)
      JJ = N1*2 + 1
      CALL PIDCK (IFLE(2),KFIL,JJ1,IBUFF(JJ))
      CALL CLOSE (KFIL,1)
      IF (JJ1) 1880,1870,1890
 1870 IF (IBUFF(JJ) .EQ. 0) GO TO 1880
      JJ1 = JJ + IBUFF(JJ) + 1
C
C     CHECK FOR MATERIAL ID UNIQUENESS IN MPT FILE
C     AND MATERIAL ID SPECIFIED IN PROPERTY CARDS
C
      KFIL = IFLE(3)
      ITRL(1) = KFIL
      CALL RDTRL (ITRL)
      J = ITRL(2) + ITRL(3) + ITRL(4) + ITRL(5) + ITRL(6) + ITRL(7)
      IBUFF(JJ1) = 1
      IF (ITRL(1).LT.0 .OR. J.EQ.0) IBUFF(JJ1) = 0
      IF (IBUFF(JJ1) .EQ. 1) CALL OPEN (*130,KFIL,IBUFF(N1+1),0)
      CALL MATCK (KFIL,IFLE(2),IBUFF(JJ),IBUFF(JJ1))
      IF (IBUFF(JJ1) .NE. 0) CALL CLOSE (KFIL,1)
 1880 CALL CLOSE (IFLE(2),1)
C
C     CHECK COORDINATE ID'S AND THEIR REFERENCES FROM
C     OTHER BULK DATA CARDS
C
 1890 JJ = NOPEN + N1 - 2
C                + N1 - 2 = 2*N1 - (N1+2)
      CALL CIDCK (IBUFF(N1+2),IBUFF,JJ)
 1900 CONTINUE
C
C     CHECK FOR ERRORS IN AXISYMMETRIC DATA
C
      IF (IAX) AXICCC = 1
      AXIFCC = IAXF
      IF (AXICCC.LE.0 .OR. AXIFCC.LE.0) GO TO 1920
      AXICCC = 0
      AXIFCC = 0
      ABORT  = .TRUE.
      CALL PAGE2 (2)
      WRITE (NOUT,1910) UFM
 1910 FORMAT (A23,' 337, BOTH AXIC AND AXIF CARDS USED IN BULK DATA.')
      GO TO 1980
 1920 IF (AXICCC .LE. 0) GO TO 1950
      IF (IAXIC  .GT. 0) GO TO 1980
      AXICCC = 0
C
C     SUPPRESS ABORT IF IT IS A UMFEDIT RUN
C
 1930 IF (IUMFED .NE. 0) GO TO 1980
      ABORT = .TRUE.
      CALL PAGE2 (2)
      WRITE (NOUT,1940) UFM
 1940 FORMAT (A23,' 338, AXISYMMETRIC CARD REQUIRED IN CASE CONTROL')
      GO TO 1980
 1950 IF (AXIFCC .LE. 0) GO TO 1960
      IF (IAXIF.GT.0 .OR. AXIFCC.EQ.2) GO TO 1980
      AXIFCC = 0
      GO TO 1930
 1960 IF (IAXIC.LE.0 .AND. IAXIF.LE.0) GO TO 1980
      AXICCC = 0
      AXIFCC = 0
C
C     SUPPRESS ABORT IF IT IS A UMFEDIT RUN
C
      IF (IUMFED .NE. 0) GO TO 1980
      ABORT = .TRUE.
      CALL PAGE2 (2)
      WRITE  (NOUT,1970) UFM
 1970 FORMAT (A23,' 339, ILLEGAL USE OF AXISYMMETRIC CARD IN CASE ',
     1       'CONTROL DECK.')
C
 1980 IF (IAPP .GE. 0) GO TO 1990
C
C     CHECK CERTAIN RESTART FLAGS BASED ON BULK DATA
C
      MN = LBD + 1
C
C     TURN ON TEMPMX$ IF MATERIALS USE TEMPS
C
      IF (T4(2,91)+T4(2,102)+T4(2,189) .EQ. 0) GO TO 1990
      IF (ANDF(IB(1),TWO(28)).EQ.0 .AND. ANDF(IB(5),TWO(32)).EQ.0 .AND.
     1    ANDF(IB(4),TWO( 6)).EQ.0 .AND. ANDF(IB(3),TWO(32)).EQ.0 .AND.
     2    ANDF(IB(4),TWO( 2)).EQ.0 .AND. ANDF(IB(4),TWO( 3)).EQ.0 .AND.
     3    ANDF(IB(4),TWO( 4)).EQ.0 ) GO TO 1990
      IB(MN) = ORF(IB(MN),TWO(19))
 1990 CALL CONMSG (IFPNA2,2,0)
C
      CALL SSWTCH (27,L27)
      IF (L27 .EQ. 0) GO TO 2060
      CALL PAGE1
      LINE = LINE + 8
      WRITE  (NOUT,2000)
 2000 FORMAT ('0DIAG 27 DUMP OF IFP TABLES AFTER IFP PROCESSING',     /,
     1        1H0,6X,6HIFX1BD,9X,6HIFX2BD,7X,6HIFX3BD,2X,6HIFX4BD,3X,
     2               6HIFX5BD,6X,6HIFX6BD                            ,/,
     3        1H ,5X,8(1H-),2X,17(1H-),2X,6(1H-),2X,6(1H-),2X,8(1H-),
     4            2X,12(1H-)                                         ,/,
     5        1H ,1X,3H(A),3X,3H(B),5X,3H(C),3X,3H(D),5X,3H(E),2X,3H(N),
     6            5X,3H(F),   3H(G),3X,3H(H),1X,3H(I),3X,3H(J),5X,3H(K),
     7            4X,3H(L),3X,3H(M),4X,3H(O),3X,4HFLAG               ,/
     8        1H0 )
 2010 FORMAT (1H ,I4,1X,2A4,I4,1X,1H(,2A4,1H),I3,I5,I4,
     1            I4,I4,I6,I3,I7,I8,16X,
     2            I1,I1,A1,I1,4X,I2)
      DO 2050 J = 1,NCDSMX
      ID = T3(1,J)
      IF (ID .LE. 0) GO TO 2020
      LF = FNM(1,ID)
      LM = FNM(2,ID)
      GO TO 2030
 2020 CONTINUE
      LF = BLANK
      LM = BLANK
 2030 CONTINUE
      N  = J
      K  = N/90 + MIN0(1,MOD(N,90))
      N  = N - 90*(K-1)
      KX = N/30 + MIN0(1,MOD(N,30))
      N  = N - 30*(KX-1)
      KY = N/6  + MIN0(1,MOD(N, 6))
      L  = N - 6*(KY-1)
      IFLAG = 0
      IF (EJECT(1) .EQ. 0) GO TO 2040
      WRITE (NOUT,2000)
      LINE = LINE + 8
 2040 CONTINUE
      LINE = LINE + 1
      WRITE (NOUT,2010) J,T1(1,J),T1(2,J),
     1                    T3(1,J),LF,LM,T3(2,J),
     2                    T4(1,J),T4(2,J),
     3                    T5(1,J),T5(2,J),
     4                    T6(1,J),T6(2,J),
     5                    T7(1,J),T7(2,J),
     6                    K,KX,OOO(KY),L,IFLAG
 2050 CONTINUE
C
 2060 RETURN
      END
C
C     THIS ROUTINE WAS RE-NUMBERED BY G.CHAN/UNISYS, 8/1992
C
C                    TABLE OF OLD vs. NEW STATEMENT NUMBERS
C
C     OLD NO.    NEW NO.      OLD NO.    NEW NO.      OLD NO.    NEW NO.
C    --------------------    --------------------    -------------------
C         50         10          557        690          991       1440
C        110         20          559        700          992       1450
C        120         30          571        710          593       1460
C        130         40                                  594       1470
C        140        100         1001        810         5950       1480
C        150        110         1002        820         5960       1490
C        160        120         1003        830         5962       1500
C        170        130         1004        840         5964       1510
C        180        140         1005        850         5966       1520
C        190        150         1006        860         5968       1530
C        501        160         1007        870         5970       1540
C        502        170         1008        880         5980       1550
C        490        180         1009        890         5990       1560
C        492        190         1010        900         6000       1570
C        500        200         1011        910         6020       1580
C        503        210         1012        920         6023       1590
C        505        220         1013        930         6025       1600
C        506        230         1014        940         6040       1610
C        507        240         1015        950         6030       1620
C        508        250         1016        960         6050       1630
C        509        260         1017        970         6053       1640
C        511        270         1018        980         6056       1650
C        512        280                                 6060       1660
C        201        300            1       1010         6080       1670
C        202        310            2       1020         7000       1680
C        203        320            3       1030         7010       1690
C        204        330            4       1040         7020       1700
C        205        340            5       1050          620       1710
C        206        350            9       1060          623       1720
C        207        400           44       1070          624       1730
C        513        410          650       1100          626       1740
C        514        420          652       1110         9101       1800
C        515        430          655       1120         9102       1810
C        516        440          657       1130         9103       1820
C        518        450          660       1140         9104       1830
C        543        460          662       1150         9105       1840
C        546        470          665       1160         9106       1850
C        517        480          670       1170         9107       1860
C        519        490          675       1180         9108       1870
C        520        500          680       1190         9109       1880
C        521        510          682       1200         9110       1890
C        527        520          685       1210         9111       1900
C        528        530          690       1220         9250       1910
C        529        540          700       1230         9200       1920
C        101        550          710       1300         9210       1930
C        530        560          712       1310         9260       1940
C        533        570          714       1320         9220       1950
C        536        580          716       1330         9230       1960
C        539        590          720       1340         9270       1970
C        544        600          561       1350         9240       1980
C        545        610          600       1360         9280       1990
C        548        620          602       1370         8010       2000
C        549        630          605       1380         8020       2010
C        560        640          590       1390         8030       2020
C        551        650          591       1400         8040       2030
C        554        660          901       1410         8045       2040
C        553        670          902       1420         8050       2050
C        555        680          903       1430         8060       2060
