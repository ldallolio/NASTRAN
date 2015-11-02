
# GNU Fortran

FC = gfortran
FFLAGS += -g -w -fno-range-check -fno-automatic -fcray-pointer

# Nastran Objects

NASTOBJS += dummy.o mapfns.o
NASTOBJS += zzcore.o xsem00.o
NASTOBJS += init.o geturn.o
NASTOBJS += klock.o waltim.o cputim.o tdate.o
NASTOBJS += conmsg.o read.o close.o
NASTOBJS += khrbcd.o khrfn1.o khrfn4.o
NASTOBJS += gino.o ginoio.o
NASTOBJS += bufchk.o
NASTOBJS += bckrec.f fwdrec.o rectyp.o
NASTOBJS += qopen.o qread.o rewind.o sgino.o write.o
NASTOBJS += bldpk.o bpack.o bunpak.o bunpk.o intpk.o pack.o unpack.o
NASTOBJS += logfil.o skpfil.o # logfil is empty
NASTOBJS += sofio.o sofiof.o
NASTOBJS += corwds.o
NASTOBJS += rdblk.o wrtblk.o
NASTOBJS += eof.o
NASTOBJS += mpyq.o
NASTOBJS += endget.o endgtb.o endput.o
NASTOBJS += getstr.o putstr.o
NASTOBJS += getstb.o
NASTOBJS += filpos.o savpos.o
NASTOBJS += emgsoc.o
NASTOBJS += defcor.o
NASTOBJS += gnfiat.o
NASTOBJS += umffd.o # Empty
NASTOBJS += k2b.o
NASTOBJS += exfort.o
NASTOBJS += rfopen.o forwrt.o fornum.o

# Fixed Field Objects

FIXOBJS += cputim.o dummy.o k2b.o khrbcd.o khrfn1.o mapfns.o waltim.o

# Nastran Library

LIBNASTRAN = ../mis/libnastran.a

# Default target

default:	nastran

all:	nastran nasthelp nastplot fixed-field check-fill

# Specific targets

nastran:	nastrn.o $(NASTOBJS)
	$(FC) $(FFLAGS) -o $@ $< $(NASTOBJS) $(LIBNASTRAN)

nasthelp:	nasthelp.o
	$(FC) $(FFLAGS) -o $@ $<

nastplot:	nastplot.o
	$(FC) $(FFLAGS) -o $@ $<

fixed-field:	ff.o $(FIXOBJS)
	$(FC) $(FFLAGS) -o $@ $< $(FIXOBJS) $(LIBNASTRAN)

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
