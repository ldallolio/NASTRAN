      SUBROUTINE CFE2AO (TPOSE,V1,V2,V3,ZB)
C*******
C     CFE2AO IS A DOUBLE PRECISION ROUTINE WHICH PERFORMS THE OPERATION
C     (A) OR (A)-TRANSPOSE FOR THE COMPLEX FEER METHOD. THIS OPERATION
C     IS CALLED THE EIGENMATRIX MULTIPLICATION.
C*******
C     DEFINITION OF INPUT AND OUTPUT PARAMETERS
C*******
C     TPOSE    = .FALSE. --- PERFORM OPERATION (A)
C              = .TRUE.  --- PERFORM OPERATION (A)-TRANSPOSE
C     V1       = INPUT  VECTOR
C     V2       = OUTPUT VECTOR
C     V3       = INPUT WORKING SPACE (FOR INTERNAL USE)
C     ZB       = INPUT GINO BUFFER
C*******
      DOUBLE PRECISION  V1(1)    ,V2(1)    ,V3(1)    ,LAMBDA
      LOGICAL           TPOSE(1) ,NO B     ,QPR
      DIMENSION         ZB(1)
      COMMON  /FEERAA/  IK(7)    ,IM(7)    ,IB(7)    ,DUMAA(117)
     2                 ,MCBLMB(7)
      COMMON  /FEERXC/  LAMBDA(2),DUM01(2) ,NORD     ,IDIAG
     2                 ,EPSDUM(2),NORTHO   ,NORD2    ,NORD4
     3                 ,NORDP1   ,DUM02(2) ,NO B     ,DUM03(4)
     4                 ,QPR
      COMMON  /SYSTEM/  KSYS     ,NOUT
C*******
      IF (QPR) WRITE (NOUT,8881) TPOSE
 8881 FORMAT(1H0,12HENTER CFE2AO,8X,11HTRANSPOSE =,L2)
      IF (TPOSE(1)) GO TO 50
C*******
C     PERFORM OPERATION (A)  = EIGENMATRIX MULTIPLICATION
C*******
      IF ( NO B ) GO TO 30
C*******
C     MULTIPLY LOWER HALF OF INPUT VECTOR BY MASS MATRIX
C*******
      CALL CFE2MY (TPOSE(1),V1(NORDP1),V3(1),IM(1),ZB(1))
      IF (QPR) WRITE (NOUT,8882) (V3(I),I=1,NORD)
 8882 FORMAT(3H --,32(4H----),/(1H ,6D21.13))
C*******
C     MULTIPLY UPPER HALF OF INPUT VECTOR BY -(LAMBDA*M+B)
C*******
      CALL CFE2MY (TPOSE(1),V1(1),V3(NORDP1),MCBLMB(1),ZB(1))
      IF (QPR) WRITE (NOUT,8882) (V3(I),I=NORDP1,NORD2)
C*******
C     CALCULATE RIGHT-HAND SIDE OF SWEEP EQUATION
C*******
      DO 10  I = 1,NORD
      J = NORD+I
   10 V2(I) = -V3(I) + V3(J)
      IF (QPR) WRITE (NOUT,8882) (V2(I),I=1,NORD)
C*******
C     PERFORM FORWARD AND BACKWARD SWEEPS
C     (GENERATES UPPER HALF OF OUTPUT VECTOR)
C*******
      CALL CF2FBS (TPOSE(1),V2(1),ZB(1))
      IF (QPR) WRITE (NOUT,8882) (V2(I),I=1,NORD)
C*******
C     COMPUTE LOWER HALF OF OUTPUT VECTOR
C*******
      DO 20  I = 1,NORD,2
      J = I+1
      NI = NORD+I
      NJ = NI+1
      V2(NI) = V1(I) + LAMBDA(1)*V2(I) - LAMBDA(2)*V2(J)
   20 V2(NJ) = V1(J) + LAMBDA(1)*V2(J) + LAMBDA(2)*V2(I)
      IF (QPR) WRITE (NOUT,8882) (V2(I),I=NORDP1,NORD2)
      GO TO 200
C*******
C     DAMPING MATRIX ABSENT
C*******
C     MULTIPLY INPUT VECTOR BY MASS MATRIX
C*******
   30 CALL CFE2MY (TPOSE(1),V1(1),V2(1),IM(1),ZB(1))
      DO 40  I = 1,NORD2
   40 V2(I) = -V2(I)
      IF (QPR) WRITE (NOUT,8882) (V2(I),I=1,NORD2)
C*******
C     PERFORM FORWARD AND BACKWARD SWEEPS
C*******
      CALL CF2FBS (TPOSE(1),V2(1),ZB(1))
      IF (QPR) WRITE (NOUT,8882) (V2(I),I=1,NORD2)
      GO TO 200
C*******
C     PERFORM OPERATION (A)-TRANSPOSE  = TRANSPOSED EIGENMATRIX
C                                                   MULTIPLICATION
C*******
   50 IF ( NO B ) GO TO 90
C*******
C     CALCULATE RIGHT-HAND SIDE OF SWEEP EQUATION
C*******
      DO 60  I = NORDP1,NORD2,2
      J = I+1
      NI = I-NORD
      NJ = NI+1
      V3(I) = V1(NI) + LAMBDA(1)*V1(I) - LAMBDA(2)*V1(J)
   60 V3(J) = V1(NJ) + LAMBDA(1)*V1(J) + LAMBDA(2)*V1(I)
      IF (QPR) WRITE (NOUT,8882) (V3(I),I=NORDP1,NORD2)
C*******
C     PERFORM BACKWARD AND FORWARD SWEEPS
C*******
      CALL CF2FBS (TPOSE(1),V3(NORDP1),ZB(1))
      IF (QPR) WRITE (NOUT,8882) (V3(I),I=NORDP1,NORD2)
C*******
C     MULTIPLY SWEEP OUTPUT VECTOR BY -(LAMBDA*M+B)-TRANSPOSE
C*******
      CALL CFE2MY (TPOSE(1),V3(NORDP1),V3(1),MCBLMB(1),ZB(1))
      IF (QPR) WRITE (NOUT,8882) (V3(I),I=1,NORD)
C*******
C     COMPUTE UPPER HALF OF OUTPUT VECTOR
C*******
      DO 70  I = 1,NORD
      J = NORD+I
   70 V2(I) = V1(J) + V3(I)
      IF (QPR) WRITE (NOUT,8882) (V2(I),I=1,NORD)
C*******
C     MULTIPLY SWEEP OUTPUT VECTOR BY TRANSPOSED MASS MATRIX
C     (GENERATES NEGATIVE OF LOWER HALF OF OUTPUT VECTOR)
C*******
      CALL CFE2MY (TPOSE(1),V3(NORDP1),V2(NORDP1),IM(1),ZB(1))
      DO 80  I = NORDP1,NORD2
   80 V2(I) = -V2(I)
      IF (QPR) WRITE (NOUT,8882) (V2(I),I=NORDP1,NORD2)
      GO TO 200
C*******
C     DAMPING MATRIX ABSENT
C*******
C     PERFORM BACKWARD AND FORWARD SWEEPS
C*******
   90 DO 95  I = 1,NORD2
   95 V3(I) = V1(I)
      CALL CF2FBS (TPOSE(1),V3(1),ZB(1))
      IF (QPR) WRITE (NOUT,8882) (V3(I),I=1,NORD2)
C*******
C     MULTIPLY SWEEP OUTPUT VECTOR BY TRANSPOSED MASS MATRIX
C*******
      CALL CFE2MY (TPOSE(1),V3(1),V2(1),IM(1),ZB(1))
      DO 100  I = 1,NORD2
  100 V2(I) = -V2(I)
      IF (QPR) WRITE (NOUT,8882) (V2(I),I=1,NORD2)
  200 RETURN
      END
