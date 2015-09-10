
# GNU Fortran

FC = gfortran
FFLAGS += -g -w -fno-range-check -fno-automatic -fcray-pointer

# Objects

OBJS += dummy.o mapfns.o
OBJS += zzcore.o xsem00.o
OBJS += init.o geturn.o
OBJS += klock.o waltim.o cputim.o tdate.o
OBJS += conmsg.o read.o close.o
OBJS += khrbcd.o khrfn1.o khrfn4.o
OBJS += gino.o ginoio.o
OBJS += bufchk.o
OBJS += bckrec.f fwdrec.o rectyp.o
OBJS += qopen.o qread.o rewind.o sgino.o write.o
OBJS += bldpk.o bpack.o bunpak.o bunpk.o intpk.o pack.o unpack.o
OBJS += logfil.o skpfil.o # logfil is empty
OBJS += sofio.o sofiof.o
OBJS += corwds.o
OBJS += rdblk.o wrtblk.o
OBJS += eof.o
OBJS += mpyq.o
OBJS += endget.o endgtb.o endput.o
OBJS += getstr.o putstr.o
OBJS += getstb.o
OBJS += filpos.o savpos.o
OBJS += emgsoc.o
OBJS += defcor.o
OBJS += gnfiat.o
OBJS += umffd.o # Empty
OBJS += k2b.o
OBJS += exfort.o

LIBNASTRAN = ../mis/libnastran.a

# Default target

default:	nastran

all:	nastran nasthelp nastplot fixed-field check-fill

# Specific targets

nastran:	nastrn.o $(OBJS)
	$(FC) $(FFLAGS) -o $@ $< $(OBJS) $(LIBNASTRAN)

nasthelp:	nasthelp.o
	$(FC) $(FFLAGS) -o $@ $<

nastplot:	nastplot.o
	$(FC) $(FFLAGS) -o $@ $<

fixed-field:	ff.o
	$(FC) $(FFLAGS) -o $@ $<

check-fill:	chkfil.f
	$(FC) $(FFLAGS) -o $@ $<

# Template rules

%.o:	%.f
	$(FC) $(FFLAGS) -c -o $@ $<

# Phony rules

.PHONY:	clean distclean

distclean:	clean
	-rm nastran
	-rm nasthelp
	-rm nastplot
	-rm fixed-field
	-rm check-fill

clean:
	-rm *.o
