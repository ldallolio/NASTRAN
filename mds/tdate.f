      SUBROUTINE TDATE (DATE)
C
C     VAX VERSION
C     ===========
C     (ALSO SiliconGraphics, DEC/ultrix, and SUN.
C      CRAY AND HP DO NOT HAVE IDATE)
C
C     THIS ROUTINE OBTAINS THE MONTH, DAY AND YEAR, IN INTEGER FORMAT
C
      INTEGER DATE(3)
C
      character*8 chdate
      character*10 time
      character*5 zone
      integer values(8)
C
      call date_and_time(chdate, time, zone, values)
C
      date(1) = values(2)        ! Month
      date(2) = values(3)        ! Day
      date(3) = values(1)        ! Year
C
      RETURN
      END
