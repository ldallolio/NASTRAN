      SUBROUTINE IFP3
C
C     DATA PROCESSING AND GENERATION OF THE AXIS-SYMETRIC-CONICAL SHELL
C
C          CARDS          TYPE       REC.ID-BIT CARDS-FILE,  CARDS-FILE
C     ===  =======      ===========  ========== ===========  ==========
C      1   AXIC     --  AX.SY.SHELL     515- 5
C      2   CCONEAX  --  AX.SY.SHELL    8515-85  CCONE-GEOM2,
C      3   FORCEAX  --  AX.SY.SHELL    2115-21  FORCE-GEOM3,
C      4   FORCE    --  STANDARD       4201-42  FORCE-GEOM3,
C      5   GRAV     --  STANDARD       4401-44   GRAV-GEOM3,
C      6   LOAD     --  STANDARD       4551-61   LOAD-GEOM3,
C      7   MOMAX    --  AX.SY.SHELL    3815-38  MOMNT-GEOM3,
C      8   MOMENT   --  STANDARD       4801-48  MOMNT-GEOM3,
C      9   MPCADD   --  STANDARD       4891-60 MPCADD-GEOM4,
C     10   MPCAX    --  AX.SY.SHELL    4015-40    MPC-GEOM4,
C     11   OMITAX   --  AX.SY.SHELL    4315-43   OMIT-GEOM4,
C     12   POINTAX  --  AX.SY.SHELL    4915-49    MPC-GEOM4, GRID-GEOM1
C     13+  RFORCE   --  STANDARD       5509-55 RFORCE-GEOM3,
C     14   RINGAX   --  AX.SY.SHELL    5615-56    SPC-GEOM4, GRID-GEOM1
C     15   SECTAX   --  AX.SY.SHELL    6315-63    MPC-GEOM4, GRID-GEOM1
C     16   SEQGP    --  STANDARD       5301-53  SEQGP-GEOM1,
C     17   SPCADD   --  STANDARD       5491-59 SPCADD-GEOM4,
C     18   SPCAX    --  AX.SY.SHELL    6215-62    SPC-GEOM4,
C     19   SUPAX    --  AX.SY.SHELL    6415-64 SUPORT-GEOM4,
C     20   TEMPAX   --  AX.SY.SHELL    6815-68   TEMP-GEOM3,
C     21   TEMPD    --  STANDARD       5641-65  TEMPD-GEOM3,
C     22   CTRIAAX  --  AX.TR.CR       7012-70  CTRIA-GEOM2
C     23   CTRAPAX  --  AX.TRA.CR      7042-74  CTRAP-GEOM2
C
      IMPLICIT INTEGER (A-Z)
      EXTERNAL        LSHIFT    ,RSHIFT    ,ANDF      ,ORF       ,
     1                COMPLF
      LOGICAL         SECD      ,NOGO      ,RECOFF    ,PIEZ
      REAL            NPHI      ,NPHI1     ,NISQ      ,NI        ,
     1                A1        ,A2        ,A3        ,A4        ,
     2                ANGLE     ,RADDEG    ,PI        ,DIFPHI    ,
     3                RZ        ,T1        ,T2        ,COEF      ,
     4                CONSTS    ,SUM       ,TWOPI
      DIMENSION       GEOM(4)   ,Z(8)      ,NUM(11)   ,INUM(11)  ,
     1                MSG1(2)   ,MSG2(2)
      CHARACTER       UFM*23    ,UWM*25    ,UIM*29    ,SFM*25
      COMMON /XMSSG / UFM       ,UWM       ,UIM       ,SFM
      COMMON /SYSTEM/ IBUFSZ    ,NOUT      ,NOFLAG    ,DUMDUM(8) ,
     1                NLINES    ,DUM1(26)  ,NBPC      ,NBPW      ,
     2                DUM37(37) ,IPIEZ
      COMMON /TWO   / TWO(32)
      COMMON /CONDAS/ CONSTS(5)
      COMMON /IFP3LV/            RECID(3)  ,RECID1(3) ,RECIDX(3) ,
     1                IEND      ,REC(3)    ,REC1(3)   ,TRAIL(7)  ,
     2                IT        ,AXTRL(7)  ,OPENFL(6) ,N         ,
     3                A1        ,CSID      ,NI        ,NISQ      ,
     4                A2        ,IBUFF1    ,IBUFF2    ,IBUFF3    ,
     5                A3        ,BUFF      ,NOGO      ,OP        ,
     6                A4        ,IHEADR    ,IBITR     ,IFILE     ,
     7                NOREG     ,LAST      ,IERRTN    ,ICONT     ,
     8                NOAXIC    ,RINGID    ,OUTBUF    ,VEOR      ,
     9                ISTART    ,IRETRN    ,FLAG      ,IAMT      ,
     O                SUM       ,IBIT      ,SETID     ,SORC      ,
     1                IBEGIN    ,MPCON     ,NWORDS    ,NNN       ,
     2                ANGLE     ,K3OR6     ,NPHI1     ,ZPT       ,
     3                NMOVE     ,CSSET     ,NOPONT    ,NON       ,
     4                IPHI      ,RECOFF    ,NPHI      ,N3OR5     ,
     5                ION       ,NPLUS1    ,NOSECT    ,COEF      ,
     6                IPT       ,COMPON    ,ICORE     ,ISCRAT    ,
     7                ICORE1    ,NCARDS    ,I1        ,IAT       ,
     8                I2        ,T1        ,T2        ,NFILE     ,
     9                NADD      ,NCARD
      COMMON /IFP3CM/ FILE(6)   ,INAME(12) ,CDTYPE(50),AXIC1(3)  ,
     1                CCONEX(3) ,FORCEX(3) ,FORCE(3)  ,GRAV(3)   ,
     2                LOAD(3)   ,MOMAX(3)  ,MOMENT(3) ,MPCADD(3) ,
     3                MPCAX(3)  ,OMITAX(3) ,POINTX(3) ,PRESAX(3) ,
     4                RINGAX(3) ,SECTAX(3) ,SEQGP(3)  ,SPCAX(3)  ,
     5                SUPAX(3)  ,TEMPAX(3) ,TEMPD(3)  ,PLOAD(3)  ,
     6                MPC(3)    ,SPC(3)    ,GRID(3)   ,SUPORT(3) ,
     7                NEG111(3) ,T65535(3) ,TEMP(3)   ,OMIT(3)   ,
     8                SPCADD(3) ,ONE       ,ZERO      ,IHEADB(96),
     9                CTRIAA(3) ,CTRAPA(3) ,ICONSO    ,RFORCE(3)
      COMMON /OUTPUT/ DUMMY(96) ,IHEAD(96)
CZZ   COMMON /ZZIFP3/ RZ(1)
      COMMON /ZZZZZZ/ RZ(1)
      EQUIVALENCE     (CONSTS(1),PI     )  ,(CONSTS(2),TWOPI  )  ,
     1                (CONSTS(4),RADDEG )  ,(Z(1)     ,RZ(1)  )  ,
     2                (GEOM(1)  ,FILE(1))  ,(SCRTCH   ,FILE(5))  ,
     3                (AXIC     ,FILE(6))  ,(NUM(11)  ,B      )  ,
     4                (NOEOR    ,INPRWD    ,ZERO)                ,
     5                (EOR      ,CLORWD    ,OUTRWD    ,ONE    )
      DATA    INUM  / 1H0,1H1,1H2,1H3,1H4,1H5,1H6,1H7,1H8,1H9,1H /
      DATA    IFIAT / 4HFIAT/, IFIST  /  4HFIST/,I5,I6 / 5,6     /
      DATA    MSG1  / 4HIFP3 , 4HBEGN /, MSG2  / 4HIFP3, 4HEND   /
C
      CALL CONMSG (MSG1,2,0)
C
C     RIGHT-JUSTIFY INUM AND CALL IT NUM
C
      DO 1 I = 1,11
    1 NUM(I) = RSHIFT(INUM(I),NBPW-NBPC)
C
C     INITIAL CHECK TO MAKE SURE TRAILER BITS ARE ALL OFF FOR GEOM1,
C     GEOM2, GEOM3, GEOM4.
C
      DO 10 I = 1,96
   10 IHEAD(I) = IHEADB(I)
C
      IF (NOFLAG) 30,20,30
   20 NOGO = .FALSE.
      GO TO 40
   30 NOGO = .TRUE.
C
   40 OPENFL(1) = 0
      OPENFL(2) = 0
      OPENFL(3) = 0
      OPENFL(4) = 0
      OPENFL(5) = 0
      OPENFL(6) = 0
      DO 110 I = 1,4
      TRAIL(1) = GEOM(I)
      CALL RDTRL (TRAIL(1))
      IF (TRAIL(1)) 50,50,70
   50 CALL PAGE2 (3)
      IMSG = 1061
      WRITE  (NOUT,55) SFM,IMSG
   55 FORMAT (A25,I5)
      WRITE  (NOUT,60) GEOM(I),INAME(2*I-1),INAME(2*I),IFIAT
   60 FORMAT (5X,11HFILE NUMBER,I4,3H ( ,2A4,12H) IS NOT IN ,A4,1H.)
      NOGO = .TRUE.
      GO TO 110
C
   70 DO 100 J = 2,7
      IF (TRAIL(J)) 80,100,80
   80 CALL PAGE2 (3)
      IMSG = 1062
      WRITE  (NOUT,55) SFM,IMSG
      WRITE  (NOUT,90) GEOM(I),INAME(2*I-1),INAME(2*I)
   90 FORMAT (5X,'FILE NUMBER',I4,3H ( ,2A4,') HAS TRAILER BIT ON.  ',
     1       'FILE SHOULD BE CLEAN AT ENTRY TO IFP3.')
      NOGO = .TRUE.
      GO TO 110
  100 CONTINUE
  110 CONTINUE
C
C     PROCEED TO SETUP CORE AND OPEN AXIC FILE
C     ICORE1 WILL ALWAYS EQUAL THE GROSS OPEN CORE TO IFP3 AT START
C
      ICORE1 = KORSZ(Z)
      IBUFF1 = ICORE1 - IBUFSZ - 2
      IBUFF2 = IBUFF1 - IBUFSZ
      IBUFF3 = IBUFF2 - IBUFSZ
      ICORE  = IBUFF3 - 1
      ICRQ   = 100 - ICORE
      IF (ICORE .LT. 100) GO TO 1310
C
C     OPEN  AXIC FILE
C
      CALL PRELOC (*1330,Z(IBUFF1),AXIC)
      OPENFL(6) = 1
      AXTRL(1)  = AXIC
      CALL RDTRL (AXTRL(1))
C
C     READ AXIC CARD
C
      CALL LOCATE (*130,Z(IBUFF1),AXIC1(1),FLAG)
      CALL READ (*1600,*130,AXIC,Z(1),2,EOR,FLAG)
      N    = Z(1)
      CSID = Z(2)
      NNN  = N
      NCARD= 1
      ASSIGN 140 TO IERRTN
      GO TO 1420
C
C     MISSING REQUIRED AXIC CARD
C
  130 ASSIGN 140 TO IERRTN
      NNN   = 0
      NCARD = 1
      GO TO 1510
  140 N = NNN
      NPLUS1 = N + 1
C
C
C     GEOM2  PROCESSING
C     =================
C
C     OPEN GEOM2
C
      IFILE= GEOM(2)
      I    = 2
      OP   = OUTRWD
      BUFF = IBUFF2
      ASSIGN 150 TO IRETRN
      GO TO 1350
C
C     CCONEAX CARDS
C
  150 REC(1) = CCONEX(1)
      REC(2) = CCONEX(2)
      REC(3) = CCONEX(3)
      NCARD  = 2
C
C     IF THERE IS NO CCONEAX CARD, THEN GO TO 1750 AND LOOK FOR
C     CTRAPAX OR CTRIAAX CARDS
C
      ICONB  = 0
      ICONSO = 0
      CALL LOCATE (*1750,Z(IBUFF1),REC(1),FLAG)
C
C     INPUT IS IN 4-WORD CARDS
C     OUTPUT IS N+1 4-WORD CARDS FOR EACH CARD INPUT
C
C     RECORD HEADER FOR CCONES
C
      ASSIGN 160 TO IHEADR
      GO TO 1470
C
  160 CALL READ (*1600,*220,AXIC,Z(1),4,NOEOR,IAMT)
C
C     CHECK RING ID-S FOR SIZE
C
      NNN = Z(3)
      ASSIGN 170 TO IERRTN
      GO TO 1440
  170 NNN = Z(4)
      ASSIGN 180 TO IERRTN
      GO TO 1440
C
C     CHECK CCONEAX ID FOR 1-9999 ALLOWABLE RANGE
C
  180 IF (Z(1).GT.0 .AND. Z(1).LT.10000) GO TO 200
      CALL PAGE2 (3)
      IMSG = 361
      WRITE  (NOUT,185) UFM,IMSG
  185 FORMAT (A23,I4)
      WRITE  (NOUT,190) Z(1)
  190 FORMAT (5X,'CCONEAX ID =',I10,'.  OUT OF 1 TO 9999 PERMISSIBLE ',
     1       'RANGE')
      NOGO = .TRUE.
C
  200 Z(1) = Z(1)*1000
      DO 210 I = 1,NPLUS1
      Z(1) = Z(1) + 1
      Z(3) = Z(3) + 1000000
      Z(4) = Z(4) + 1000000
      IF (NOGO) GO TO 210
      CALL WRITE (GEOM(2),Z(1),4,NOEOR)
  210 CONTINUE
      GO TO 160
C
C     OUT OF CCONEAX CARDS
C
  220 IF (IAMT) 230,240,230
C
C     GO TO 356 FOR RECORD ERROR
C
  230 ASSIGN 260 TO IERRTN
      GO TO 1490
C
C     WRITE EOR AND PUT BITS IN TRAILER
C
  240 ASSIGN 250 TO IRETRN
      ICONSO = 1
      GO TO 1270
  250 ICONB = 1
      GO TO 1750
C
C     CLOSE GEOM2
C
  260 I = 2
      ASSIGN 270 TO IRETRN
      GO TO 1380
C
C     GEOM3 PROCESSING
C     ================
C
C     OPEN GEOM3
C
  270 IFILE= GEOM(3)
      I    = 3
      OP   = OUTRWD
      BUFF = IBUFF2
      ASSIGN 280 TO IRETRN
      GO TO 1350
C
C     FORCE, FORCEAX, MOMNT, AND MOMNTAX CARDS
C
  280 RECID(1) = FORCE(1)
      RECID(2) = FORCE(2)
      RECID(3) = FORCE(3)
      RECIDX(1)= FORCEX(1)
      RECIDX(2)= FORCEX(2)
      RECIDX(3)= FORCEX(3)
      NCARD    = 3
      ASSIGN 620 TO ICONT
C
C     SET NOREG = 0 OR 1, DEPENDING ON PRESSENCE OF RECID
C     SET NOAXIC= 0 OR 1, DEPENDING ON PRESSENCE OF RECIDX
C
  290 IBIT = RECIDX(2)
      ASSIGN 300 TO IBITR
      GO TO 1460
  300 NOAXIC = NON
      IBIT = RECID(2)
      ASSIGN 310 TO IBITR
      GO TO 1460
  310 NOREG = NON
C
      REC(1) = RECID(1)
      REC(2) = RECID(2)
      REC(3) = RECID(3)
C
      IF (NOAXIC) 340,320,340
  320 IF (NOREG ) 330,610,330
C
C     TRANSFER FORCE OR MOMENT RECORD DIRECTLY.
C     THERE ARE NO FORCEAX OR MOMAX CARDS RESPECTIVELY.
C
  330 ASSIGN 610 TO IRETRN
      GO TO 1230
C
C     AT 410 READ IN ALL FORCEAX OR MOMNTAX CARDS AND PUT OUT ON GEOM(3)
C     IF NOREG=0,AND ON SCRTCH IF NOREG NON-ZERO.FIRST WRITE 3-WORD-
C     REC ID ON GEOM3.
C
  340 ASSIGN 350 TO IHEADR
      GO TO 1470
C
C     OPEN SCRATCH IF NEEDED
C
  350 IF (NOREG) 360,370,360
  360 I    = 5
      OP   = OUTRWD
      BUFF = IBUFF3
      ASSIGN 370 TO IRETRN
      GO TO 1350
  370 CALL LOCATE (*1530,Z(IBUFF1),RECIDX(1),FLAG)
  380 CALL READ (*1600,*440,AXIC,Z(1),8,NOEOR,IAMT)
C
C     CHECK RING ID
C
      ASSIGN 390 TO IERRTN
      NNN = Z(2)
      GO TO 1440
C
C     CHECK HARMONIC NUMBER AND FOR A SEQUENCE OF HARMONICS
C
  390 IF (Z(4) .EQ. 0) GO TO 396
      II   = 1
      NH1  = 0
      NH2  = 0
      SECD = .TRUE.
      WORD = 4
      DO 391 IJ = 1,2
      DO 392 IX = 1,4
      CHR = RSHIFT(LSHIFT(Z(WORD),NBPC*IABS(IX-4)),NBPW-NBPC)
      IF (CHR .EQ. B) GO TO 392
      DO 393 I = 1,10
      K = I-1
      IF (NUM(I) .EQ. CHR) GO TO 394
  393 CONTINUE
      SECD = .FALSE.
      II   = 1
      GO TO 392
  394 IF (SECD) GO TO 395
      NH1 = NH1 + II*K
      II  = II*10
      GO TO 392
  395 NH2 = NH2 + II*K
      II  = II*10
  392 CONTINUE
  391 WORD = WORD -1
      IF (NH1 .LE. NH2) GO TO 398
      WORD = NH1
      NH1  = NH2
      NH2  = WORD
  398 NNN  = NH1
      ASSIGN 397 TO IERRTN
      GO TO 1420
  396 NH1  = Z(3)
      NH2  = Z(3)
  397 NNN  = NH2
      ASSIGN 400 TO IERRTN
      GO TO 1420
  400 Z(4) = Z(5)
      Z(5) = Z(6)
      Z(6) = Z(7)
      Z(7) = Z(8)
      NH1  = NH1 + 1
      NH2  = NH2 + 1
      SUM  = Z(2)
      MUS  = Z(2)
      DO 430 I = NH1,NH2
      Z(2) = MUS + I*1000000
      Z(3) = 0
C
C     OUTPUT TO GEOM(3) IF NOREG = 0
C     OUTPUT TO SCRTCH  IF NOREG = NON-ZERO
C
      IF (NOGO ) GO TO 380
      IF (NOREG) 420,410,420
  410 NFILE = GEOM(3)
      GO TO 430
  420 NFILE = SCRTCH
  430 CALL WRITE (NFILE,Z(1),7,NOEOR)
      GO TO 380
C
C     OUT OF CARDS
C
  440 IF (IAMT) 450,460,450
C
C     CHECK FOR RECORD INCONSISTANCY ERROR.
C
  450 REC(1) = RECIDX(1)
      REC(2) = RECIDX(2)
      REC(3) = RECIDX(3)
      ASSIGN 460 TO IERRTN
      GO TO 1490
C
  460 IF (NOREG) 470,590,470
C
C     CLOSE THE SCRTCH FILE AND THEN MERGE SCRTCH WITH AXIC
C     ON TO GEOM3
C
  470 I = 5
      ASSIGN 480 TO IRETRN
      GO TO 1380
C
C     OPEN SCRTCH FILE FOR INPUT AND LOCATE FORCE OR MOMENT CARDS ON
C     AXIC FILE.
C
  480 ASSIGN 490 TO IRETRN
      OP = INPRWD
      GO TO 1350
  490 CALL LOCATE (*1560,Z(IBUFF1),RECID(1),FLAG)
      IF (NOGO) GO TO 610
C
      CALL READ (*1600,*600,AXIC,Z(1),7,NOEOR,IAMT)
      CALL READ (*1610,*1610,SCRTCH,Z(8),7,NOEOR,IAMT)
C
  500 IF (Z(1) .LE. Z(8)) GO TO 510
C
      NFILE  = SCRTCH
      OUTBUF = 8
      GO TO 520
C
  510 NFILE  = AXIC
      OUTBUF = 1
C
  520 IF (NOGO) GO TO 610
      CALL WRITE (GEOM(3),Z(OUTBUF),7,NOEOR)
      CALL READ (*1620,*540,NFILE,Z(OUTBUF),7,NOEOR,IAMT)
      GO TO 500
C
C     OK ALL WORDS PROCESSED FOR FILE-NFILE
C
  540 IF (NFILE .EQ. AXIC) GO TO 550
      NFILE  = AXIC
      OUTBUF = 1
      GO TO 560
  550 NFILE  = SCRTCH
      OUTBUF = 8
  560 IF (NOGO) GO TO 610
      CALL WRITE (GEOM(3),Z(OUTBUF),7,NOEOR)
      CALL READ (*1620,*580,NFILE,Z(OUTBUF),7,NOEOR,IAMT)
      GO TO 560
C
C     CLOSE SCRTCH, WRITE EOR, AND PUT BITS IN TRAILER.
C
  580 I = 5
      ASSIGN 590 TO IRETRN
      GO TO 1380
  590 ASSIGN 610 TO IRETRN
      GO TO 1270
C
C     RECORD LENGTH ERROR
C
  600 REC(1) = RECID(1)
      REC(2) = RECID(2)
      REC(3) = RECID(3)
      ASSIGN 610 TO IERRTN
      GO TO 1490
C
  610 GO TO ICONT, (620,650)
C
C     GRAV CARD
C
  620 REC(1) = GRAV(1)
      REC(2) = GRAV(2)
      REC(3) = GRAV(3)
      ASSIGN 630 TO IRETRN
      GO TO 1230
C
C     LOAD CARD
C
  630 REC(1) = LOAD(1)
      REC(2) = LOAD(2)
      REC(3) = LOAD(3)
      ASSIGN 640 TO IRETRN
      GO TO 1230
C
C     MOMENT AND MOMAX CARDS
C
  640 RECID(1)  = MOMENT(1)
      RECID(2)  = MOMENT(2)
      RECID(3)  = MOMENT(3)
      RECIDX(1) = MOMAX(1)
      RECIDX(2) = MOMAX(2)
      RECIDX(3) = MOMAX(3)
      NCARD = 7
      ASSIGN 650 TO ICONT
      GO TO 290
C
C     PRESAX CARD
C
  650 CALL LOCATE (*722,Z(IBUFF1),PRESAX(1),FLAG)
C
C     RECORD HEADER FOR PRESAX CARDS IS FORMED HERE
C
      REC(1) = PRESAX(1)
      REC(2) = PRESAX(2)
      REC(3) = PRESAX(3)
      NCARD  = 13
      ASSIGN 660 TO IHEADR
      GO TO 1470
C
  660 CALL READ (*1600,*700,AXIC,Z(1),6,NOEOR,IAMT)
C
C     CREATE N+1 CARDS OF SAME LENGTH AS INPUT CARD.
C
C     CHECK RING ID-S IN FIELDS 3 AND 4 FOR PROPER SIZE.
C
C     CHECK FOR PIEZOELECTRIC
C
      PIEZ = .FALSE.
      IF (IPIEZ.EQ.1 .AND. Z(3).LT.0) PIEZ = .TRUE.
      IF (.NOT. PIEZ) GO TO 661
      Z(3) = -Z(3)
  661 CONTINUE
      NNN = Z(3)
      ASSIGN 670 TO IERRTN
      GO TO 1440
  670 NNN = Z(4)
      ASSIGN 680 TO IERRTN
      GO TO 1440
C
  680 DIFPHI = ABS(RZ(I6) - RZ(I5))
      DO 690 I = 1,NPLUS1
      Z(7) = I - 1
      Z(3) = Z(3) + 1000000
      IF (PIEZ) Z(3) = -Z(3)
      Z(4) = Z(4) + 1000000
      IF (NOGO) GO TO 690
      IF (DIFPHI .EQ. 0.0) GO TO 690
      IF (I.GT.1 .AND. ABS(DIFPHI-360.).LT.1.E-6) GO TO 690
      CALL WRITE (GEOM(3),Z(1),7,NOEOR)
      IF (PIEZ) Z(3) = -Z(3)
  690 CONTINUE
      GO TO 660
C
C     OUT OF PRESAX CARDS
C
  700 IF (IAMT) 710,720,710
C
C     CHECK FOR RECORD INCONSISTANCY ERROR.
C
  710 ASSIGN 722 TO IERRTN
      REC(1) = PRESAX(1)
      REC(2) = PRESAX(2)
      REC(3) = PRESAX(3)
      GO TO 1490
C
C     WRITE EOR AND PUT BITS IN TRAILER
C
  720 ASSIGN 722 TO IRETRN
      GO TO 1270
C
C     RFORCE CARD
C
 722  CALL LOCATE (*730,Z(IBUFF1),RFORCE(1),FLAG)
      REC(1) = RFORCE(1)
      REC(2) = RFORCE(2)
      REC(3) = RFORCE(3)
      NCARD  = 24
      ASSIGN 723 TO IHEADR
      GO TO 1470
C
C     PROCESS RFORCE DATA
C
  723 CALL READ (*1600,*725,AXIC,Z(1),7,NOEOR,IAMT)
      IF (Z(2).EQ.0 .AND. Z(3).EQ.0 .AND. Z(5).EQ.0 .AND. Z(6).EQ.0)
     1    GO TO 7240
      WRITE  (NOUT,724) UFM,Z(1)
  724 FORMAT (A23,' 336, RFORCE DATA IN SET NO.',I8,
     1       ' CONTAINS ILLEGAL DIRECTION FOR AXISYMMETRIC PROBLEM')
      NOGO = .TRUE.
      GO TO 723
 7240 Z(2) = 0
      Z(3) = 0
      Z(5) = 0
      Z(6) = Z(7)
      Z(7) = 0
      CALL WRITE (GEOM(3),Z(1),7,NOEOR)
      GO TO 723
C
C     END OF RFORCE CARDS
C
  725 IF (IAMT) 726,727,726
C
C     RECORD INCONSISTENCY ERROR
C
  726 ASSIGN 730 TO IERRTN
      REC(1) = RFORCE(1)
      REC(2) = RFORCE(2)
      REC(3) = RFORCE(3)
      GO TO 1490
C
C     WRITE EOR AND BITS IN TRAILER
C
  727 ASSIGN 730 TO IRETRN
      GO TO 1270
C
C     TEMPD CARD
C
  730 REC(1) = TEMPD(1)
      REC(2) = TEMPD(2)
      REC(3) = TEMPD(3)
      ASSIGN 740 TO IRETRN
      IF (NOGO) GO TO 740
      CALL LOCATE (*740,Z(IBUFF1),REC(1),FLAG)
      CALL WRITE (IFILE,REC(1),3,NOEOR)
      VEOR = 0
  735 CALL READ (*1600,*738,AXIC,Z(1),ICORE,NOEOR,IAMT)
      IAMT = ICORE
  736 DO 737 I = 1,IAMT,2
  737 Z(I) = Z(I) + 100000000
      CALL WRITE (IFILE,Z(1),IAMT,0)
      DO 739 I = 1,IAMT,2
  739 Z(I) = Z(I) + 100000000
      CALL WRITE (IFILE,Z(1),IAMT,VEOR)
      IF (VEOR) 1290,735,1290
  738 VEOR = 1
      GO TO 736
C
C     TEMPAX CARD
C
  740 CALL LOCATE (*1210,Z(IBUFF1),TEMPAX(1),FLAG)
C
C     RECORD HEADER ON GEOM3 FOR TEMP CARDS
C
      REC(1) = TEMP(1)
      REC(2) = TEMP(2)
      REC(3) = TEMP(3)
      NCARD  = 20
      ASSIGN 750 TO IHEADR
      GO TO 1470
C
C     AT 604(?) SET UP SCRATCH FILE.
C
  750 I    = 5
      BUFF = IBUFF3
      OP   = OUTRWD
      ASSIGN 760 TO IRETRN
      GO TO 1350
C
C     PICK UP FIRST TEMPAX CARD = 4 WORDS.
C
  760 LAST = 0
      CALL READ (*1600,*1200,AXIC,Z(1),4,NOEOR,IAMT)
  770 K = 0
      SETID = Z(1)
      RINGID= Z(2)
C
C     CHECK RING ID FOR PROPER RANGE OF VALUE
C
      NNN = RINGID
      ASSIGN 780 TO IERRTN
      GO TO 1440
C
  780 IAT = 3
  790 K   = K + 1
      IAT = IAT + 2
      ICRQ= IAT + 3 - ICORE
      IF (ICORE .LT. IAT+3) GO TO 1310
C
C     ALL TEMPAX CARDS HAVING SAME SET AND RING ID MUST BE ABLE TO
C     HAVE 2 WORDS EACH FIT IN CORE.
C
      Z(IAT  ) = Z(3)
      Z(IAT+1) = Z(4)
C
      CALL READ (*1600,*1130,AXIC,Z(1),4,NOEOR,IAMT)
C
C     DOES THIS CARD HAVE SAME SET AND RING ID AS LAST IN CURRENT SERIES
C
      IF (Z(1) .NE. SETID ) GO TO 800
      IF (Z(2) .NE. RINGID) GO TO 800
      GO TO 790
C
C     WE HAVE A  K X 2  ARRAY OF  PHI-S  AND T-S.
C
C     CONVERT ALL  PHIS SUCH THAT (0.LE. PHI .LT.TWOPI)
C
  800 IEND   = IAT + 1
      IBEGIN = 5
C
      DO 840 I = IBEGIN,IEND,2
      ANGLE = RZ(I)
      IF (ANGLE) 810,840,830
  810 IF (ANGLE) 820,840,840
  820 ANGLE = ANGLE + 360.0
      GO TO 810
C
  830 IF (ANGLE .LT. 360.0) GO TO 840
      ANGLE = ANGLE - 360.0
      GO TO 830
C
  840 RZ(I) = ANGLE*RADDEG
C
C     SIMPLE SORT FOR THE K X 2  MATRIX.
C     SORT IS PERFORMED ON COLUMN 1 ONLY
C
      IF (K .EQ. 1) GO TO 950
      ISTART = IBEGIN + 2
      DO 900 I = ISTART,IEND,2
      IAT = I - 2
      IF (RZ(I) .GE. RZ(IAT)) GO TO 900
C
C     ROW NOT HIGH ENOUGH.  MOVE IT UP.
C
  850 IAT = IAT - 2
      IF (IAT-IBEGIN) 870,870,860
  860 IF (RZ(I) .LT. RZ(IAT)) GO TO 850
      IAT = IAT + 2
      GO TO 880
  870 IAT = IBEGIN
C
C     THE ELEMENTS (I) AND (I+1) WILL BE MOVED UP TO POSITIONS (IAT) AND
C     (IAT+1) AND ELEMENTS (IAT) THRU (I-1) WILL BE  MOVED DOWN 1 ROW.
C
C     FIRST SAVE THE ROW BEING MOVED UP
C
  880 RZ(IEND+1) = RZ(I)
      RZ(IEND+2) = RZ(I+1)
      NMOVE = I - IAT
      IAT   = I + 2
      DO 890 J = 1,NMOVE
      IAT = IAT - 1
  890 RZ(IAT) = RZ(IAT-2)
C
C     REPLACE SAVE ROW IN NEW SLOT
C
      RZ(IAT-2) = RZ(IEND+1)
      RZ(IAT-1) = RZ(IEND+2)
C
  900 CONTINUE
C
C     CHECK FOR ANY DUPLICATE ANGLES AND REMOVE THEM...
C
      IBEGIN = IBEGIN + 2
  910 DO 920 I = IBEGIN,IEND,2
      IF (Z(I) .EQ. Z(I-2)) GO TO 930
  920 CONTINUE
      GO TO 950
C
C     DUPLICATE, SHRINK LIST UP OVER IT.
C
  930 IEND = IEND - 2
      K=K-1
      DO 940 J = I,IEND,2
      Z(J  ) = Z(J+2)
  940 Z(J+1) = Z(J+3)
      IBEGIN = I
      IF (IBEGIN - IEND) 910,950,950
C
C     SET UP K + 1  CARD
C
  950 RZ(IEND+1) = RZ(I5) + TWOPI
      RZ(IEND+2) = RZ(I6)
C
C     THERE ARE K CARDS NOW WITH SETID, AND RINGID, NOT INCLUDING THE
C     K + 1ST CARD
C
C     N+1 TEMP CARDS FOR S SET (PUT ON GEOM3)
C     N+1 TEMP CARDS FOR C SET (PUT ON SCRTCH FOR NOW)
C
C     NOTE FMMS-52  (10/04/67) PAGE -9- FOR FOLLOWING...
C
      CSSET = 1
      SETID = SETID + 100000000
C
C     CSSET = 0 FOR C-SET  AND NON-ZERO FOR S-SET.
C
      IBEGIN = K + K + 7
      ICRQ   = IBEGIN + 2 - ICORE
      IF ((IBEGIN+2) .GT. ICORE) GO TO 1310
C
  960 NADD = 0
      Z(IBEGIN) = SETID
      DO 1100 I = 1,NPLUS1
      NADD = NADD + 1000000
C
C     NI IS REAL
C
      NI   = I - 1
      NISQ = (I-1)**2
      Z(IBEGIN+1) = RINGID + NADD
      IPHI = 3
      IT   = 4
      SUM  = 0.0E0
      IF (NI   ) 1010,970,1010
  970 IF (CSSET) 1000,980,1000
  980 DO 990 IK = 1,K
      IPHI = IPHI + 2
      IT   = IT   + 2
  990 SUM  = SUM  + (RZ(IT)+RZ(IT+2))*(RZ(IPHI+2)-RZ(IPHI))
 1000 RZ(IBEGIN+2) = 0.25*SUM/PI
      GO TO 1060
C
C     NON-ZERO NI
C
 1010 IF (K .EQ. 1) GO TO 1050
      DO 1040 IK = 1,K
      IPHI = IPHI + 2
      IT   = IT   + 2
      NPHI = NI*RZ(IPHI  )
      NPHI1= NI*RZ(IPHI+2)
C
      IF (CSSET) 1030,1020,1030
C
C     C-SET
C
 1020 A1 =  SIN(NPHI1)
      A2 = -SIN(NPHI )
      A3 =  COS(NPHI1)
      A4 = -COS(NPHI )
      GO TO 1040
C
C     S-SET
C
 1030 A1 = -COS(NPHI1)
      A2 =  COS(NPHI )
      A3 =  SIN(NPHI1)
      A4 = -SIN(NPHI )
C
C
 1040 SUM = SUM + (((RZ(IT)*RZ(IPHI+2) - RZ(IT+2)*RZ(IPHI))*
     1      (A1 + A2)/NI) + ((RZ(IT+2) - RZ(IT))*
     2      (A3 + A4 + NPHI1*A1 + NPHI*A2)/NISQ))/
     3      (RZ(IPHI+2) - RZ(IPHI))
C
 1050 RZ(IBEGIN+2) = SUM/PI
C
 1060 IF (NOGO ) GO TO 1105
      IF (CSSET) 1070,1080,1070
 1070 NFILE = GEOM(3)
      GO TO 1090
 1080 NFILE = SCRTCH
 1090 CALL WRITE (NFILE,Z(IBEGIN),3,NOEOR)
 1100 CONTINUE
 1105 IF (CSSET) 1110,1120,1110
 1110 CSSET = 0
      SETID = SETID + 100000000
      GO TO 960
C
C     THIS SERIES OF TEMPAX CARDS COMPLETE GO FOR MORE IF LAST = 0
C
 1120 IF (LAST) 1140,770,1140
 1130 LAST = 1
      GO TO 800
C
C     ALL TEMPAX CARDS COMPLETE. CLOSE SCRATCH, OPEN SCRATCH
C     AND COPY SCRATCH TO GEOM3.
C
 1140 IF (NOGO) GO TO 1210
      CALL WRITE (SCRTCH,Z(1),0,EOR)
      CALL CLOSE (SCRTCH,CLORWD)
      CALL OPEN  (*1640,SCRTCH,Z(IBUFF3),INPRWD)
C
      VEOR = 0
 1150 CALL READ (*1610,*1170,SCRTCH,Z(1),ICORE,NOEOR,IAMT)
      IAMT = ICORE
 1160 CALL WRITE (GEOM(3),Z(1),IAMT,VEOR)
      IF (VEOR) 1180,1150,1180
 1170 VEOR = 1
      GO TO 1160
C
C     ALL  TEMPAX  CARDS  PROCESSED.
C
 1180 CALL CLOSE (SCRTCH,CLORWD)
C
C     PUT BITS IN TRAILER FOR TEMP CARDS WRITTEN
C
      REC(1) = TEMP(1)
      REC(2) = TEMP(2)
      REC(3) = TEMP(3)
      ASSIGN 1210 TO IRETRN
      GO TO 1290
C
C     RECORD LENGTH ERROR
C
 1200 REC(1) = TEMPAX(1)
      REC(2) = TEMPAX(2)
      REC(3) = TEMPAX(3)
      ASSIGN 1210 TO IERRTN
      GO TO 1490
C
C     CLOSE GEOM3
C
 1210 I = 3
      ASSIGN 1220 TO IRETRN
      GO TO 1380
C
C     CTRIAAX CARD
C
 1700 REC(1) = CTRIAA (1)
      REC(2) = CTRIAA (2)
      REC(3) = CTRIAA (3)
      NCARD  = 43
      CALL LOCATE (*1800,Z(IBUFF1),REC(1),FLAG)
C
C     RECORD HEADER FOR CTRIAAX
C
      ASSIGN 1710 TO IHEADR
      ICONB  = 2
      ICONSO = 1
      GO TO 1470
 1710 CALL READ (*1600,*1770,AXIC,Z(1),6,NOEOR,IAMT)
      Z(1) = Z(1)*1000
      DO 1720 I = 1,NPLUS1
      Z(1) = Z(1) + 1
      Z(3) = Z(3) + 1000000
      Z(4) = Z(4) + 1000000
      Z(5) = Z(5) + 1000000
      IF (NOGO) GO TO 1720
      CALL WRITE (GEOM(2),Z(1),6,NOEOR)
 1720 CONTINUE
      GO TO 1710
C
C     OUT OF CTRIAAX CARD
C
 1770 IF (IAMT) 1730,1740,1730
 1730 ASSIGN 260 TO IERRTN
      GO TO 1490
C
C     PUT BITS IN TRILER
C
 1740 ASSIGN 260 TO IRETRN
      GO TO 1270
 1800 IF (ICONSO .EQ. 1) GO TO 1740
      ASSIGN 260 TO IERRTN
C
C     MISSING REQUIRED CCONEAX OR CTRIAAX OR CTRAPAX CARD
C
      CALL PAGE2 (3)
      IMSG = 362
      WRITE (NOUT,185) UFM,IMSG
      WRITE (NOUT,1910) CDTYPE(3),CDTYPE(4),CDTYPE(43),CDTYPE(44),
     1                  CDTYPE(45),CDTYPE(46)
 1910 FORMAT (5X,'MINIMUM PROBLEM REQUIRES ',2A4,2H,  ,2A4,4H OR ,2A4,
     1       ' CARD.  NONE FOUND')
      NOGO = .TRUE.
      GO TO IERRTN, (260,240)
C
C     CTRAPAX CARD
C     ============
C
 1750 REC(1) = CTRAPA (1)
      REC(2) = CTRAPA (2)
      REC(3) = CTRAPA (3)
      CALL LOCATE (*1700,Z(IBUFF1),REC(1),FLAG)
      ICONB  = 1
C
C     RECORD HEADER FOR CTRAPAX
C
      ASSIGN 1751 TO IHEADR
      ICONSO = 1
      GO TO 1470
 1751 CALL READ (*1600,*1753,AXIC,Z(1),7,NOEOR,IAMT)
      Z(1) = Z(1)*1000
      DO 1752 I = 1,NPLUS1
      Z(1) = Z(1) + 1
      Z(3) = Z(3) + 1000000
      Z(4) = Z(4) + 1000000
      Z(5) = Z(5) + 1000000
      Z(6) = Z(6) + 1000000
      IF (NOGO) GO TO 1752
      CALL WRITE (GEOM(2),Z(1),7,NOEOR)
 1752 CONTINUE
      GO TO 1751
C
C     OUT OF CTRAPAX CARD
C
 1753 IF (IAMT) 1754,1755,1754
 1754 ASSIGN 260 TO IERRTN
      GO TO 1490
C
C     PUT BITS IN TRILER
C
 1755 ASSIGN 260 TO IRETRN
      IF (NOGO) GO TO 1300
      CALL WRITE (IFILE,Z(1),IAMT,EOR)
      I1 = (REC(2)-1)/16 + 2
      I2 = REC(2) - (I1-2)*16 + 16
      TRAIL (I1) = ORF(TRAIL(I1),TWO(I2))
      GO TO 1700
C
C     GEOM4 AND GEOM1 PROCESSING IS PERFORMED IN IFP3B ROUTINE
C                                                =====
C
 1220 CALL IFP3B
      GO TO 1570
C
C     UTILITY SECTION FOR IFP3
C     AXIS-SYMETRIC-CONICAL-SHELL DATA GENERATOR.
C     ==========================================
C
C     COMMON CODE FOR TRANSFER OF RECORD FROM AXIC FILE TO SOME
C     OTHER FILE
C
 1230 CALL LOCATE (*1300,Z(IBUFF1),REC(1),FLAG)
      IF (NOGO) GO TO 1300
      CALL WRITE (IFILE,REC(1),3,NOEOR)
 1260 CALL READ (*1600,*1270,AXIC,Z(1),ICORE,NOEOR,IAMT)
      IAMT = ICORE
      CALL WRITE (IFILE,Z(1),IAMT,NOEOR)
      GO TO 1260
 1270 IF (NOGO) GO TO 1300
      IF (IFILE .EQ. GEOM(3)) GO TO 1280
      IF (IFILE.EQ.GEOM(2) .AND. ICONB.EQ.1) GO TO 1300
 1280 CALL WRITE (IFILE,Z(1),IAMT,EOR)
C
C     PUT BITS IN TRAILER
C
 1290 I1 = (REC(2)-1)/16 + 2
      I2 =  REC(2) - (I1-2)*16 + 16
      TRAIL(I1) = ORF(TRAIL(I1),TWO(I2))
C
 1300 GO TO IRETRN, (250,260,610,630,640,722,730,740,1210)
C
C     OUT OF CORE
C
 1310 CALL PAGE2 (4)
      IMSG = 363
      WRITE  (NOUT, 185) IMSG
      WRITE  (NOUT,1320) ICRQ
 1320 FORMAT (5X,'INSUFFICIENT CORE TO PROCESS AXIC DATA IN SUBROUTINE',
     1       'IFP3', /5X,'ADDITIONAL CORE NEEDED =',I8,' WORDS.')
      NOGO = .TRUE.
C
C     GO TO FATAL ERROR RETURN
C
      GO TO 1570
C
C     AXIC FILE NOT IN FIST
C
 1330 CALL PAGE2 (3)
      IMSG = 1061
      WRITE (NOUT,55) SFM,IMSG
      WRITE (NOUT,60) AXIC,INAME(11),INAME(12),IFIST
      NOGO = .TRUE.
C
C     GO TO FATAL ERROR RETURN
C
      GO TO 1570
C
C     OPEN A FILE AND GET THE TRAILER
C
 1350 IF (NOGO) GO TO 1360
      CALL OPEN (*1370,FILE(I),Z(BUFF),OP)
      OPENFL(I) = 1
      IF (I .GT. 4) GO TO 1360
C
C     WRITE THE HEADER RECORD
C
      CALL WRITE (FILE(I),INAME(2*I-1),2,EOR)
      TRAIL(1) = FILE(I)
      CALL RDTRL (TRAIL(1))
C
 1360 GO TO IRETRN, (150,280,370,760,490)
C
 1370 CALL PAGE2 (3)
      IMSG = 1061
      WRITE (NOUT,55) SFM,IMSG
      WRITE (NOUT,60) FILE(I),INAME(2*I-1),INAME(2*I),IFIST
      NOGO = .TRUE.
      GO TO 1570
C
C     CLOSE A FILE
C
 1380 IF (OPENFL(I)) 1390,1410,1390
 1390 IF (I.GT. 4) GO TO 1400
      CALL WRITE (FILE(I),T65535(1),3,EOR)
 1400 CALL CLOSE (FILE(I),CLORWD)
      OPENFL(I) = 0
      IF (I .GT. 4) GO TO 1410
      CALL WRTTRL (TRAIL(1))
 1410 GO TO IRETRN, (270,590,1220,480)
C
C     HARMONIC NUMBER ... ON CARD TYPE ...... IS OUT OF RANGE 0 TO 998
C
 1420 IF (NNN.LT.999 .AND. NNN.GE.0 .AND. NNN.LE.N)
     1    GO TO IERRTN, (140,400,397)
      CALL PAGE2 (3)
      IMSG = 364
      WRITE  (NOUT,185 ) UFM,IMSG
      WRITE  (NOUT,1430) NNN,CDTYPE(2*NCARD-1),CDTYPE(2*NCARD),N
 1430 FORMAT (5X,'HARMONIC NUMBER ',I6,4H ON ,2A4,' CARD OUT OF 0 TO ',
     1        I4,' ALLOWABLE RANGE.')
      NOGO = .TRUE.
      GO TO IERRTN, (140,400,397)
C
C     RING ID OUT OF PERMISSABLE RANGE OF 1 TO 999999
C
 1440 IF (NNN.GT.0 .AND. NNN.LE.999999)
     1    GO TO IERRTN, (170,180,390,670,680,780)
      CALL PAGE2 (3)
      IMSG = 365
      WRITE  (NOUT,185 ) UFM,IMSG
      WRITE  (NOUT,1450) NNN,CDTYPE(2*NCARD-1),CDTYPE(2*NCARD)
 1450 FORMAT (5X,'RING ID',I10,4H ON ,2A4,' CARD OUT OF 1 TO 999999 ',
     1       'ALLOWABLE RANGE')
      NOGO = .TRUE.
      GO TO IERRTN, (170,180,390,670,680,780)
C
C     CHECK BIT-IBIT IN TRAILER AND RETURN NON = ZERO OR NON-ZERO...
C
 1460 I1 = (IBIT-1)/16 + 2
      I2 = IBIT - (I1-2)*16 + 16
      NON = ANDF(AXTRL(I1),TWO(I2))
      GO TO IBITR, (300,310)
C
C     WRITE 3 WORD RECORD HEADER
C
 1470 IF (NOGO) GO TO 1480
      CALL WRITE (IFILE,REC(1),3,NOEOR)
 1480 GO TO IHEADR, (160,350,660,723,750,1710,1751)
C
C     END-OF-RECORD ON AXIC FILE
C
 1490 CALL PAGE2 (3)
      IMSG = 1063
      WRITE  (NOUT,55) SFM,IMSG
      WRITE  (NOUT,1500) CDTYPE(2*NCARD-1),CDTYPE(2*NCARD)
 1500 FORMAT (5X,'EOR ON AXIC FILE WHILE READING ',2A4,'CARD RECORDS.')
      NOGO = .TRUE.
      GO TO IERRTN, (260,460,610,722,730,1210)
C
C     MISSING REQUIRED CARD
C
 1510 CALL PAGE2 (3)
      IMSG = 362
      WRITE  (NOUT,185 ) UFM,IMSG
      WRITE  (NOUT,1520) CDTYPE(2*NCARD-1),CDTYPE(2*NCARD)
 1520 FORMAT (5X,'MINIMUM PROBLEM REQUIRES ',2A4,' CARD.  NONE FOUND.')
      NOGO = .TRUE.
      GO TO IERRTN, (260,140)
C
C     AXIC TRAILER BIT ON BUT CAN NOT LOCATE RECORD
C
 1530 CALL PAGE2 (3)
      IMSG = 1064
      WRITE  (NOUT,55) SFM,IMSG
      WRITE  (NOUT,1540) CDTYPE(2*NCARD-1),CDTYPE(2*NCARD)
 1540 FORMAT (5X,2A4,' CARD COULD NOT BE LOCATED ON AXIC FILE AS ',
     1       'EXPECTED')
 1550 NOGO = .TRUE.
      GO TO 610
 1560 CALL PAGE2 (2)
      WRITE (NOUT,1540) RECID(1),RECID(2),RECID(3)
      GO TO 1550
C
C     CLOSE ANY OPEN FILES AND RETURN
C
 1570 DO 1590 I = 1,6
      IF (OPENFL(I)) 1580,1590,1580
 1580 CALL CLOSE (FILE(I),CLORWD)
      OPENFL(I) = 0
 1590 CONTINUE
      IF (NOGO) NOFLAG = 32767
      CALL CONMSG (MSG2,2,0)
      RETURN
C
C     EOF ENCOUNTERED READING AXIC FILE.
C
 1600 NFILE = AXIC
      IN  = 11
      IN1 = 12
      GO TO 1620
 1610 NFILE = SCRTCH
      IN  = 9
      IN1 = 10
 1620 CALL PAGE2 (3)
      IMSG = 3002
      WRITE  (NOUT,55) SFM,IMSG
      WRITE  (NOUT,1630) INAME(IN),INAME(IN1),NFILE
 1630 FORMAT (5X,'EOF ENCOUNTERED WHILE READING DATA SET ',2A4,' (FILE',
     1        I4,') IN SUBROUTINE IFP3')
      NOGO = .TRUE.
      GO TO 1570
C
 1640 I = 5
      GO TO 1370
      END
