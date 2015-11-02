
      SUBROUTINE CONMSG (MESAGE, NWORDS, IDUMMY)
!     Modified by Harry Schaeffer 06/27/2015 to replace time by date_and_time      
C
C     THIS ROUTINE IS THE CONSOLE MESSAGE WRITER FOR
C     THE VAX VERSION OF NASTRAN
C
      character (len=12) real_clock(3), time
      integer values(8)
      character(4) cvalues(8)
      equivalence(values,cvalues)      
      INTEGER CPUTIM, CPUSTR
      INTEGER WALLTM, WALSTR
C
      DIMENSION MESAGE(1), ITIME(2)        
C
      COMMON /SYSTEM/ ISYSTM(100)
C
      EQUIVALENCE (ISYSTM( 2), NOUT  ),
     *            (ISYSTM(18), CPUSTR),
     *            (ISYSTM(32), WALSTR)
C
C
C     GET THE CURRENT TIME
C
!      CALL TIME (ITIME)
      call date_and_time(real_clock(1), time, Real_clock(3),
     1                  values)      
C
C     GET THE WALL CLOCK TIME ELAPSED SINCE THE START OF JOB
C
      CALL WALTIM (WALLTM)
      WALSEC = WALLTM - WALSTR
      IF (WALSEC.LT.0.0) WALSEC = WALSEC + 86400.0
C
C     GET THE CPU TIME TAKEN SINCE THE START OF JOB
C
      CALL KLOCK (CPUTIM)
      CPUSEC = CPUTIM - CPUSTR
C
      MWORDS = MIN0 (NWORDS, 15)
!hgs      WRITE (4, 2000) ITIME, WALSEC, CPUSEC, (MESAGE(I), I = 1, MWORDS)
      WRITE (4, 2000) time(1:2),time(3:4),time(5:10), WALSEC, CPUSEC, 
     1               (MESAGE(I), I = 1, MWORDS)
      call flush(4)     
      RETURN
 2000 FORMAT (1X, a2,':',a2,':',a6,':', F9.1, 12H ELAPSED SEC,
     1        F10.1, 8H CPU SEC, 3X, A4,  2X, 2A4, 2X, 12A4)        
      END
