      SUBROUTINE FREAD (FILE,BLOCK,N,EOR)
C
      INTEGER FILE,EOR
      REAL BLOCK(1),SUBNAM(2)
      DATA SUBNAM / 4H FRE,4HAD  /
C
      CALL READ (*100,*101,FILE,BLOCK,N,EOR,K)
      RETURN
  100 K = -2
      GO TO 110
  101 K = -3
  110 CALL MESAGE (K,FILE,SUBNAM)
      GO TO 110
      END
