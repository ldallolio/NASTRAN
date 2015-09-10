      SUBROUTINE GFSMT(MT,MMAT,MROW)
C
C     ROUTINE TO ADD 1.0 TO ROW MROW AND COLUMN MROW OF MT TO PREVENT
C     SINGULARITIES IN THE MASS MATRIX FOR GIVINS
C
      DOUBLE PRECISION        VAL
C
      INTEGER       Z        ,SYSBUF   ,MCB(7)   ,NAME(2)  ,MMAT
     1             ,MT       ,INBLK(15),OUTBLK(15)
C
C     OPEN CORE
C
CZZ   COMMON / ZZSSB2 /        Z(1)
      COMMON / ZZZZZZ /        Z(1)
C
C     SYSTEM COMMON
      COMMON / SYSTEM /       SYSBUF
C
C
C     PACK - UNPACK COMMON BLOCKS
C
      COMMON / ZBLPKX /       A(4)     ,IROW
C
      EQUIVALENCE   ( VAL , A(1) )
C
      DATA NAME / 4HGFSM , 4HT    /
      DATA INBLK / 15*0 /, OUTBLK / 15*0 /
C
C
      MCB(1) = MT
      CALL RDTRL(MCB)
      NROW = MCB(2)
C
C     ALLOCATE BUFFERS
C
      NZ = KORSZ(Z(1))
      IBUF1 = NZ - SYSBUF
      IBUF2 = IBUF1 - SYSBUF
      NZ = IBUF2 - 1
      IF(NZ .LT. 100) GO TO 1008
C
C     OPEN FILES
C
      CALL MAKMCB(MCB,MMAT,NROW,1,2)
      INBLK(1) = MT
      OUTBLK(1) = MMAT
      CALL GOPEN(MT,Z(IBUF1),0)
      CALL GOPEN(MMAT,Z(IBUF2),1)
C
C     COPY RECORDS UP TO MROW
C
      IF(MROW .EQ. 1) GO TO 310
      MR = MROW - 1
      DO 300 I=1,MR
      CALL CPYSTR(INBLK,OUTBLK,0,0)
  300 CONTINUE
C
C    PACK OUT COLUMN MROW WITH A 1.0 IN ROW MROW.  THE COLUMN IS NULL
C     IN MT SO IT IS SKIPPED
C
  310 CALL BLDPK(2,2,MMAT,0,0)
      IROW = MROW
      VAL = 1.0D0
      CALL ZBLPKI
      CALL BLDPKN(MMAT,0,MCB)
C
      IF(MROW .GE. NROW) GO TO 320
      CALL FWDREC(*1002,MT)
C
C     BLAST OUT REST OF FILE
C
      CALL CPYFIL(MT,MMAT,Z,NZ,ICNT)
C
C     CLOSE FILES
C
  320 CALL CLOSE(MT,1)
      CALL CLOSE(MMAT,1)
C
C     COPY TRAILER OVER.  THE DENSITY WILL BE SLIGHTLY OFF BECAUSE
C     OF THE NEW TERM BUT IT:S CLOSE
C
      MCB(1) = MT
      CALL RDTRL(MCB)
      MCB(1) = MMAT
      CALL WRTTRL(MCB)
      RETURN
C
C     ERRORS
C
 1002 CALL MESAGE(-2,MT,NAME)
 1008 CALL MESAGE(-8,0,NAME)
      RETURN
      END
