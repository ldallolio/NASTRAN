      SUBROUTINE MBGATE(NTOTE,DPHITE,N,YWTE,Q,Q1,Q2,KTE,KTE1,KTE2)
C
C     SUM ON TRAILING EDGE
C
      LOGICAL CNTRL1,CNTRL2
      DIMENSION YWTE(1),KTE(1),KTE1(1),KTE2(1)
      COMPLEX Q(1),Q1(1),Q2(1),DPHITE(3,N),DPHI
      COMMON /MBOXC/ NJJ ,CRANK1,CRANK2,CNTRL1,CNTRL2
      COMMON /MBOXA/ X(12),Y(12)
      DO   1400   J = 1 , NTOTE
      DPHI  =  DPHITE(1,J) * 0.5 * AMIN0(J,2)
      IF(CNTRL1.AND.YWTE(J).GE.Y(7).AND.YWTE(J).LE.Y(11)) GO TO 1100
      IF(CNTRL2.AND.YWTE(J).GT.Y(11).AND.YWTE(J).LE.Y(12)) GO TO 1150
      ISP=KTE(J)
      Q(ISP) = DPHI
      GO TO 1300
 1100 ISP=KTE1(J)
      Q1(ISP) = DPHI
      GO TO 1300
 1150 ISP=KTE2(J)
      Q2(ISP) = DPHI
 1300 CONTINUE
 1400 CONTINUE
      RETURN
      END
