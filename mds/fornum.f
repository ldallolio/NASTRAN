      SUBROUTINE FORNUM ( FORM, ICHAR, IMULT )
C
C THIS SUBROUTINE CONVERTS ALL NUMBERS TO INTEGER FORMAT
C
      CHARACTER*1   FORM(200), BLANK, NUMBER(2)
      DATA          BLANK /' ' /
      DATA          NUMBER /'0','9'/
      IMULT = 0
10    IF ( FORM( ICHAR ) .NE. BLANK      ) GO TO 20
      ICHAR = ICHAR + 1
      GO TO 10
20    IF ( FORM( ICHAR ) .LT. NUMBER(1) .OR.
     &     FORM( ICHAR ) .GT. NUMBER(2) ) GO TO 700
      READ ( FORM( ICHAR ), 901 ) II
901   FORMAT(I1)
      IMULT = IMULT*10 + II
      ICHAR = ICHAR + 1
      GO TO 20
700   CONTINUE
      RETURN
      END

