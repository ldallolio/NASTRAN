      SUBROUTINE MTRXI (FILE,NAME,ITEM,DUMBUF,ITEST)        
C        
C     COPIES MATRIX ITEM OF SUBSTRUCTURE NAME FROM THE SOF TO THE       
C     NASTRAN FILE        
C     ITEST VALUES RETURNED ARE        
C        1 - NORMAL RETURN        
C        2 - ITEM PSEUDO-EXISTS ONLY ON THE SOF        
C        3 - ITEM DOES NOT EXIST ON THE SOF        
C        4 - NAME DOES NOT EXIT        
C        5 - ITEM IS NOT ONE OF THE ALLOWABLE MATRIX ITEMS        
C        6 - THE NASTRAN FILE HAS BEEN PURGED        
C        
      EXTERNAL        RSHIFT, ANDF        
      INTEGER         RSHIFT, ANDF, TRAIL(7), FILE, BUF(1), EOF,        
     1                NMSBR(2), NAME(2), OLDBUF, BLKSIZ        
      COMMON /MACHIN/ MACH, IHALF, JHALF        
      COMMON /SOF   / DITDUM(6), IO, IOPBN, IOLBN, IOMODE        
      COMMON /SYS   / BLKSIZ        
CZZ   COMMON /XNSTRN/ NSTRN        
      COMMON /ZZZZZZ/ NSTRN        
CZZ   COMMON /SOFPTR/ BUF        
      EQUIVALENCE     (BUF(1), NSTRN)        
      DATA    NMSBR / 4HMTRX,4HI   /        
      DATA    IRD   / 1 /,   IDLE  / 0 /,  IFETCH / -1 /        
C        
C     CHECK IF ITEM IS ONE OF THE FOLLOWING ALLOWABLE NAMES.        
C     KMTX, MMTX, PVEC, POVE, UPRT, HORG, UVEC, QVEC, PAPP, POAP, LMTX  
C        
      CALL CHKOPN (NMSBR(1))        
      ITM = ITTYPE(ITEM)        
      IF (ITM .NE. 1) GO TO 1030        
C        
C     MAKE SURE BUFFER IS DOUBLE WORD ALIGNED, OPEN NASTRAN FILE, AND   
C     ADUST SOF BUFFER TO COINCIDE WITH GINO        
C     ALSO DETERMINE PLACEMENT OF MATRIX NAME IN FIRST BUFFER        
C        
      IDISP = LOCFX(BUF(IO-2)) - LOCFX(NSTRN)        
      IF (ANDF(IDISP,1) .NE. 0) IO = IO + 1        
      IOPT = 1        
      CALL OPEN (*1000,FILE,BUF(IO-2),IOPT)        
      OLDBUF = IO        
C        
      IN = 4        
      IF (MACH.EQ.3 .OR. MACH.EQ.4) GO TO 40        
      IN = 7        
      IF (BUF(IO-2) .EQ. FILE) GO TO 40        
      IO = IO + 1        
      IF (BUF(IO-2) .NE. FILE) GO TO 1010        
C        
C     OPEN ITEM TO READ AND FETCH FIRST BLOCK FROM SOF        
C        
   40 CONTINUE        
      CALL SFETCH (NAME(1),ITEM,IFETCH,ITEST)        
      IF (ITEST .NE. 1) GO TO 1050        
C        
C     INSERT CORRECT MATRIX NAME INTO BUFFER        
C        
      CALL FNAME (FILE,BUF(IO+IN))        
C        
C     WRITE BLOCK ON NASTRAN FILE        
C        
      ASSIGN 50 TO IJUMP        
      EOF = 0        
   50 IF (BUF(IO+1) .LE. 0) GO TO 90        
      CALL WRTBLK (FILE,EOF)        
C        
C     READ NEXT SOF BLOCK        
C        
   60 CALL FNXT (IOPBN,INXT)        
      IF (MOD(IOPBN,2) .EQ. 1) GO TO 70        
      NEXT = ANDF(RSHIFT(BUF(INXT),IHALF),JHALF)        
      GO TO 80        
   70 NEXT = ANDF(BUF(INXT),JHALF)        
   80 IF (NEXT .EQ. 0) GO TO 1020        
      IOPBN = NEXT        
      IOLBN = IOLBN + 1        
      CALL SOFIO (IRD,IOPBN,BUF(IO-2))        
      GO TO IJUMP, (50,100)        
C        
C     LAST DATA BLOCK HAS BEEN READ FROM SOF        
C        
   90 ITRAIL = BUF(IO+1)        
      BUF(IO+1) = IOLBN        
      IF (ITRAIL .GE. 0) GO TO 97        
      TRAIL(1) = FILE        
      DO 95 I = 2,7        
      TRAIL(I) = BUF(IO+BLKSIZ-7+I)        
   95 CONTINUE        
      CALL WRTTRL (TRAIL)        
   97 EOF = 1        
      CALL WRTBLK (FILE,EOF)        
      CALL CLOSE (FILE,1)        
      IF (ITRAIL .NE. 0) GO TO 120        
C        
C     TRAILER IS STORED ON NEXT SOF BLOCK - READ IT        
C        
      ASSIGN 100 TO IJUMP        
      GO TO 60        
C        
C     WRITE TRAILER OF NASTRAN DATA BLOCK        
C        
  100 TRAIL(1) = FILE        
      DO 110 I = 2,7        
  110 TRAIL(I) = BUF(IO+BLKSIZ-7+I)        
      CALL WRTTRL (TRAIL)        
  120 ITEST = 1        
      IO = OLDBUF        
      RETURN        
C        
C     ERROR RETURNS        
C        
C        
C     NASTRAN FILE PURGED        
C        
 1000 ITEST = 6        
      IOMODE = IDLE        
      RETURN        
C        
C     BUFFER ALIGNMENT ERROR        
C        
 1010 CALL SOFCLS        
      CALL MESAGE (-8,0,NMSBR)        
C        
C     SOF CHAINING ERROR        
C        
 1020 CALL ERRMKN (19,9)        
      RETURN        
C        
C     INVALID ITEM NAME        
C        
 1030 ITEST = 5        
      RETURN        
C        
C     ERROR IN SFETCH CALL        
C        
 1050 CALL CLOSE (FILE,1)        
      IO = OLDBUF        
      RETURN        
C        
      END        
