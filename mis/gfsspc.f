      SUBROUTINE GFSSPC(NUY,PVEC)
C
C     ROUTINE TO CALCULATE A PARTITIONING VECTOR TO REMOVE FIRST
C     ROW AND COLUMN OF FLUID STIFFNESS MATRIX IF NO SPC'S ARE ON
C     THE FLUID
C
      INTEGER       MCB(7)   ,PVEC     ,Z        ,SYSBUF   ,NAME(2)
C
C     OPEN CORE
C
CZZ   COMMON / ZZSSB2 /        Z(1)
      COMMON / ZZZZZZ /        Z(1)
C
C     SYSTEM COMMON
C
      COMMON / SYSTEM /       SYSBUF
C
C     PACK - UNPACK COMMON BLOCKS
C
      COMMON / ZBLPKX /       A(4)     ,IROW
C
      DATA NAME / 4HGFSS , 4HPC   /
C
C     ALLOCATE CORE
C
      NZ = KORSZ(Z(1))
      IBUF = NZ - SYSBUF
      NZ = IBUF - 1
      IF(NZ .LT. 0) GO TO 1008
C
      NUY1 = NUY - 1
      CALL MAKMCB(MCB,PVEC,NUY,2,1)
      CALL GOPEN(PVEC,Z(IBUF),1)
      CALL BLDPK(1,1,PVEC,0,0)
      A(1) = 1.0
      IROW = 1
      CALL ZBLPKI
      CALL BLDPKN(PVEC,0,MCB)
      CALL CLOSE(PVEC,1)
      CALL WRTTRL(MCB)
      RETURN
C
C     ERRORS
C
 1008 CALL MESAGE(-8,0,NAME)
      RETURN
      END
